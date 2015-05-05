package com.smarttrade.webappsdk.training.server;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ponysdk.core.main.Main;
import com.ponysdk.core.servlet.ApplicationLoader;
import com.ponysdk.core.servlet.HttpServlet;
import com.smarttrade.webappsdk.training.client.TrainingEntryPoint;


public class Run {

    private static Logger log = LoggerFactory.getLogger(Run.class);

    public static void main(final String[] args) {
        try {
            // Start webserver
            final ApplicationLoader applicationLoader = new ApplicationLoader();
            final HttpServlet httpServlet = new HttpServlet();
            httpServlet.setEntryPointClassName(TrainingEntryPoint.class.getName());

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