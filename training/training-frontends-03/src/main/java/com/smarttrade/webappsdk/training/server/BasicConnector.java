
package com.smarttrade.webappsdk.training.server;

import java.util.concurrent.Callable;
import java.util.concurrent.Executor;
import java.util.concurrent.ExecutorCompletionService;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.smarttrade.connect.MessageCracker;
import com.smarttrade.connect.STConnect;
import com.smarttrade.messages.Message;
import com.smarttrade.messaging.ClientAdapterConfigurationImpl;
import com.smarttrade.messaging.ClientAdapterFactory;
import com.smarttrade.messaging.CommunicationStatusListener;
import com.smarttrade.messaging.stamp.TcpSTAMPClientAdapterProperties;
import com.smarttrade.services.BaseInvokationService;
import com.smarttrade.services.TransactionMessageServiceDispatcher;
import com.smarttrade.st.common.clustering.ConnectionState;
import com.smarttrade.st.common.clustering.ConnectionState.State;
import com.smarttrade.webappsdk.core.server.connector.ConnectionException;
import com.smarttrade.webappsdk.core.server.filter.MessageFilter;
import com.smarttrade.webappsdk.core.server.filter.MessageFilterChain;
import com.smarttrade.webappsdk.core.server.filter.impl.MessageFilterChainFactory;

public class BasicConnector extends MessageCracker implements CommunicationStatusListener, MessageFilter, BaseInvokationService {

    protected static final Logger log = LoggerFactory.getLogger(BasicConnector.class);

    private STConnect stconnect;
    protected ConnectionState currentState = new ConnectionState();

    private String uri;

    private final Executor watchDog = Executors.newSingleThreadExecutor();
    protected final ExecutorCompletionService<Boolean> executor = new ExecutorCompletionService<Boolean>(Executors.newSingleThreadExecutor());
    private final ScheduledExecutorService scheduledExecutor = Executors.newScheduledThreadPool(1);

    private MessageFilterChainFactory chainFactory;

    protected ConnectionTask connectionTask;

    public BasicConnector() {}

    public void start() {
        log.info("Starting stconnect");

        watchDog.execute(new Runnable() {

            @Override
            public void run() {
                while (true) {
                    try {
                        final Boolean succeeded = executor.take().get();
                        if (succeeded) return;

                        if (currentState.state == State.DOWN) scheduleTask(connectionTask);
                    } catch (final Throwable e) {
                        log.error("Cannot process task", e);
                    }
                }
            }
        });

        connectionTask = new ConnectionTask();

        initSTConnect();

        executor.submit(connectionTask);
    }

    protected void initSTConnect() {
        final ClientAdapterConfigurationImpl config = new ClientAdapterConfigurationImpl();
        config.setAdapterURI(uri);
        config.setApplicationName("Webtrading");
        final TcpSTAMPClientAdapterProperties props = new TcpSTAMPClientAdapterProperties();
        props.setReconnectInterval(5);
        config.setAdapterProperties(props);
        config.setHeartBeatPeriod(5);

        stconnect = new STConnect(ClientAdapterFactory.newClientAdapter(config), config);
        stconnect.addCommunicationStatusListener(this);
        stconnect.addMessageListener(this);
        stconnect.init();
    }

    protected void scheduleTask(final Callable<Boolean> task) {
        log.info("Schedule a task attempt in 5s");
        scheduledExecutor.schedule(new Runnable() {

            @Override
            public void run() {
                executor.submit(task);
            }
        }, 5, TimeUnit.SECONDS);
    }

    @Override
    public void doFilter(final Message message, final MessageFilterChain messageFilterChain) {
        if (!currentState.isConnected()) throw new ConnectionException("Unavailable connection", currentState);

        sendMessage(message);

        // next ?
        if (messageFilterChain != null) messageFilterChain.doFilter(message);
    }

    @Override
    public void sendMessage(final Message message) {
        TransactionMessageServiceDispatcher.dispatch(stconnect, message);
    }

    @Override
    public void onCommunicationReady(final String nodeName) {
        log.info("onCommunicationReady #" + nodeName);
        currentState.state = State.CONNECTED;
        currentState.nodeName = nodeName;
    }

    @Override
    public void onHeartBeatFailure(final String nodeName) {
        log.info("onHeartBeatFailure #" + nodeName);
        currentState.state = State.DOWN;
        currentState.nodeName = nodeName;
        scheduleTask(connectionTask);
    }

    @Override
    protected void takeAction(final Message message) {
        // Notify cache, ui, ...
        final MessageFilterChain filterChain = chainFactory.newMessageFilterChain();
        filterChain.doFilter(message);
    }

    protected boolean isConnectionReady() {
        return stconnect.isReady();
    }

    class ConnectionTask implements Callable<Boolean> {

        @Override
        public Boolean call() throws Exception {
            try {
                return isConnectionReady();
            } catch (final Throwable e) {
                currentState.state = State.DOWN;
                log.error("Cannot establish connection");
                return false;
            }
        }
    }

    public void setUri(final String uri) {
        this.uri = uri;
    }

    public void setChainFactory(final MessageFilterChainFactory chain) {
        this.chainFactory = chain;
    }

}
