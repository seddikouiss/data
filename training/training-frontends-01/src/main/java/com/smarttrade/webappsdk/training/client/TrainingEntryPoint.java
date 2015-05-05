
package com.smarttrade.webappsdk.training.client;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.ponysdk.core.UIContext;
import com.ponysdk.core.main.EntryPoint;
import com.ponysdk.ui.server.basic.PButton;
import com.ponysdk.ui.server.basic.PFlowPanel;
import com.ponysdk.ui.server.basic.PHTML;
import com.ponysdk.ui.server.basic.PLabel;
import com.ponysdk.ui.server.basic.PPanel;
import com.ponysdk.ui.server.basic.PRootLayoutPanel;
import com.ponysdk.ui.server.basic.PSplitLayoutPanel;
import com.ponysdk.ui.server.basic.event.PClickEvent;
import com.ponysdk.ui.server.basic.event.PClickHandler;
import com.ponysdk.ui.terminal.PUnit;

public class TrainingEntryPoint implements EntryPoint {

    private static Logger log = LoggerFactory.getLogger(TrainingEntryPoint.class);

    private final File root = new File(".");
    public PButton but;

    @Override
    public void start(final UIContext uiContext) {
        start();
    }

    @Override
    public void restart(final UIContext uiContext) {
        start();
    }

    private void start() {

        final ArrayList<File> files = (ArrayList<File>) getFiles(new File("./folder_exo1"), false);
        final PSplitLayoutPanel container = new PSplitLayoutPanel(PUnit.PX);
        final PPanel flowlayoutPanel = new PFlowPanel();
        container.addWest(flowlayoutPanel, 200);

        final PHTML phtml = new PHTML();
        container.addWest(phtml, 500);
        final PLabel labelTitle = new PLabel("Browser : ");

        flowlayoutPanel.add(labelTitle);
        final Iterator<File> iter = files.iterator();
        for (; iter.hasNext();) {
            final File file = iter.next();
            final PLabel labelFile = new PLabel(file.getName());

            labelFile.addClickHandler(new PClickHandler() {

                @Override
                public void onClick(final PClickEvent event) {
                    phtml.setHTML(getFileContent(file));

                }
            });
            flowlayoutPanel.add(labelFile);
        }
        PRootLayoutPanel.get().add(container);

        // For the layout use PSplitLayoutPanel and PFlowPanel
        // To display file/folder names use PLabel
        // Listen to click event by adding a PClicKHandler on the PLabel
        // To display row html/txt use PHTML.setHTML(..)

    }

    protected Collection<File> getFiles(final File root, final boolean folders) {
        System.out.println(root.toString());
        if (!root.isDirectory()) return Collections.emptyList();

        final List<File> files = new ArrayList<File>();
        for (final File f : root.listFiles()) {
            if (folders && f.isDirectory()) files.add(f);
            if (!folders && !f.isDirectory()) files.add(f);
        }
        return files;
    }

    protected String getFileContent(final File f) {
        final StringBuilder str = new StringBuilder();
        try {
            final boolean txtFile = f.getName().endsWith("txt");
            final Scanner scanner = new Scanner(f);
            while (scanner.hasNextLine()) {
                str.append(scanner.nextLine());
                if (txtFile) str.append("<br>");
            }
            scanner.close();
        } catch (final FileNotFoundException e) {
            log.error("", e);
        }
        return str.toString();
    }

}
