
package com.smarttrade.webappsdk.training.client.page;

import com.ponysdk.core.place.Place;
import com.ponysdk.ui.server.basic.PLabel;
import com.smarttrade.webappsdk.widgets.datagrid.DataGridPageActivity;

public class WelcomePage extends DataGridPageActivity {

    public static final String PAGE_NAME = "Welcome";

    public WelcomePage() {
        super(PAGE_NAME, "Static data");
    }

    @Override
    protected void onInitialization() {

    }

    @Override
    protected void onFirstShowPage() {
        final PLabel label = new PLabel("Hello");
        pageView.setWidget(label);
    }

    @Override
    protected void onShowPage(final Place place) {}

    @Override
    protected void onLeavingPage() {}

}
