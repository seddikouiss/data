
package com.smarttrade.webappsdk.training.server;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ponysdk.core.main.Main;
import com.ponysdk.spring.service.SpringApplicationLoader;
import com.smarttrade.webappsdk.core.server.servlet.SpringHttpServlet;

public class Run {

    private static Logger log = LoggerFactory.getLogger(Run.class);

    public static void main(final String[] args) {
        try {
            // Start webserver
            final SpringApplicationLoader applicationLoader = new SpringApplicationLoader();
            applicationLoader.setServerConfiguration("training_server.xml");

            final SpringHttpServlet httpServlet = new SpringHttpServlet();
            httpServlet.addClientConfiguration("conf/client_application.inc.xml");
            httpServlet.addClientConfiguration("training_client.xml");

            final Main main = new Main();
            main.setApplicationContextName("training");
            main.setPort(8081);
            main.setHttpServlet(httpServlet);
            main.setHttpSessionListener(applicationLoader);
            main.setServletContextListener(applicationLoader);
            main.start();
        } catch (final Exception e) {
            log.error("", e);
        }
    }

}