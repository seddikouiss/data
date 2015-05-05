
package com.smarttrade.webappsdk.training;

import com.smarttrade.ibus.instruments.LoadableInstrumentProvider;
import com.smarttrade.messages.STMessageFactory;
import com.smarttrade.messages.fields.SecurityClassID;
import com.smarttrade.messages.fields.SecurityID;
import com.smarttrade.messages.structures.SecurityDefinition;

public class InMemoryInstrumentLoader implements com.smarttrade.ibus.instruments.InMemoryInstrumentLoader {

    private final String[] currencies = { "EUR", "USD", "GBP", "AUD", "CHF", "JPY", "CAD" };

    @Override
    public void load(final LoadableInstrumentProvider lip) {

        for (int i = 0; i < currencies.length; i++) {
            for (int j = 0; j < currencies.length; j++) {
                if (i == j) continue;

                final String symbol = currencies[i] + "/" + currencies[j];
                final SecurityDefinition sd = STMessageFactory.newSecurityDefinition(SecurityID.createSecurityID(symbol));
                sd.setSymbol(symbol);
                sd.setSecurityClassID(SecurityClassID.createSecurityClassID("1"));
                sd.setSecurityClassName("Class1");
                lip.loadInstrument(sd);
            }
        }

    }

}
