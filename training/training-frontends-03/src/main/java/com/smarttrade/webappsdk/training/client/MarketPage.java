
package com.smarttrade.webappsdk.training.client;

import java.util.ArrayList;
import java.util.List;

import com.ponysdk.core.place.Place;
import com.ponysdk.ui.server.basic.PFlowPanel;
import com.ponysdk.ui.server.basic.PLabel;
import com.ponysdk.ui.server.basic.PScrollPanel;
import com.ponysdk.ui.server.basic.PSplitLayoutPanel;
import com.ponysdk.ui.server.basic.PWidget;
import com.ponysdk.ui.terminal.PUnit;
import com.smarttrade.messages.fields.Query;
import com.smarttrade.messages.structures.SecurityDefinition;
import com.smarttrade.messages.structures.SecurityList;
import com.smarttrade.webappsdk.clustering.STServiceSender;
import com.smarttrade.webappsdk.clustering.STServiceSenderInvoker;
import com.smarttrade.webappsdk.clustering.annotation.OnSecurityList;
import com.smarttrade.webappsdk.clustering.atom.MessageDispatcher;
import com.smarttrade.webappsdk.core.client.widget.AbstractWidget;
import com.smarttrade.webappsdk.factory.element.Element;
import com.smarttrade.webappsdk.services.ServiceRegistry;
import com.smarttrade.webappsdk.services.cache.SecurityCache;

public class MarketPage extends AbstractWidget {

    private static final Query FIND_ALL_SECURITIES = Query.createQuery("find instrument i where true;");

    private PSplitLayoutPanel layout;
    private PFlowPanel securities;
    private PFlowPanel markets;

    SecurityCache securityService;

    @Override
    public PWidget asWidget() {
        return layout;
    }

    @Override
    protected void onFirstShow() {

        securityService = ServiceRegistry.getService(SecurityCache.class);

        // Listen to ST message
        MessageDispatcher.get().addMessageListener(this);

        final PScrollPanel left = Element.newPScrollPanel();
        final PScrollPanel right = Element.newPScrollPanel();
        layout = Element.newPSplitLayoutPanel(PUnit.PX);
        securities = Element.newPFlowPanel();
        markets = Element.newPFlowPanel();
        layout.addWest(left, 250);
        layout.add(right);
        left.setWidget(securities);
        right.setWidget(markets);
        final STServiceSender st = STServiceSenderInvoker.get();
        // st.sendRPCRequest(RPCRequestBean.);

        final List<SecurityDefinition> allSecurities = new ArrayList<SecurityDefinition>(securityService.getSecurities());
        securities.add(new PLabel("Display all securities here"));
        System.out.println(allSecurities.size());
        for (int i = 0; i < allSecurities.size(); ++i) {
            securities.add(new PLabel(allSecurities.get(i).toString()));
        }

        markets.add(new PLabel("Display all best bid/best offer here for each subscribed market"));
    }

    @Override
    protected void onShow(final Place place) {

    }

    @OnSecurityList
    public void onSecurityList(final SecurityList securityList) {
        securityList.getSecurities();
    }
}
