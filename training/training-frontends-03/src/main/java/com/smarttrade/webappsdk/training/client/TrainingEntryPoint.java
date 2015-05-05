
package com.smarttrade.webappsdk.training.client;

import com.ponysdk.core.place.Place;
import com.ponysdk.ui.server.basic.PRootLayoutPanel;
import com.smarttrade.messages.structures.LogonResponse;
import com.smarttrade.webappsdk.atoms.login.LoginAtom;
import com.smarttrade.webappsdk.clustering.annotation.OnLogonResponse;
import com.smarttrade.webappsdk.clustering.atom.MessageDispatcher;
import com.smarttrade.webappsdk.core.client.entrypoint.EntryPoint;
import com.smarttrade.webappsdk.core.shared.context.UserContext;

// Extends EntryPoint from webappsdk that wait the websocket initialization
public class TrainingEntryPoint extends EntryPoint {

    @Override
    protected void start() {
        MessageDispatcher.get().addMessageListener(this);

        final LoginAtom loginAtom = new LoginAtom();
        loginAtom.start();
        PRootLayoutPanel.get().add(loginAtom);
    }

    @OnLogonResponse
    public void onLogonResponse(final LogonResponse logonResponse) {
        if (logonResponse.getAuthenticationResponse().getCanLogin()) {
            // keep the user in the session
            UserContext.get().init(logonResponse);

            final MarketPage marketPage = new MarketPage();
            marketPage.show(Place.NOWHERE);

            PRootLayoutPanel.get().clear();
            PRootLayoutPanel.get().add(marketPage);
        }
    }

}