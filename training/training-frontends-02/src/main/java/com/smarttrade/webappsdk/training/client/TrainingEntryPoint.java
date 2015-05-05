
package com.smarttrade.webappsdk.training.client;

import com.ponysdk.core.UIContext;
import com.ponysdk.impl.webapplication.page.place.PagePlace;
import com.ponysdk.spring.client.SpringEntryPoint;
import com.smarttrade.webappsdk.training.client.page.WelcomePage;

public class TrainingEntryPoint extends SpringEntryPoint {

    @Override
    public void start(final UIContext uiContext) {
        start(new PagePlace(WelcomePage.PAGE_NAME));
    }

    @Override
    public void restart(final UIContext uiContext) {
        start(new PagePlace(WelcomePage.PAGE_NAME));
    }

}