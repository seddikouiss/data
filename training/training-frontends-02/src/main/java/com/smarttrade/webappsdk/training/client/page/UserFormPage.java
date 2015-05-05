
package com.smarttrade.webappsdk.training.client.page;

import com.ponysdk.core.place.Place;
import com.ponysdk.ui.server.basic.PButton;
import com.ponysdk.ui.server.basic.PFlowPanel;
import com.ponysdk.ui.server.basic.event.PClickEvent;
import com.ponysdk.ui.server.basic.event.PClickHandler;
import com.ponysdk.ui.server.form2.Form;
import com.ponysdk.ui.server.form2.FormFieldComponent;
import com.ponysdk.ui.server.form2.formfield.StringTextBoxFormField;
import com.ponysdk.ui.server.form2.validator.NotEmptyFieldValidator;
import com.smarttrade.messages.STMessageFactory;
import com.smarttrade.messages.fields.Login;
import com.smarttrade.messages.structures.User;
import com.smarttrade.webappsdk.services.ServiceRegistry;
import com.smarttrade.webappsdk.training.service.user.UserService;
import com.smarttrade.webappsdk.widgets.datagrid.DataGridPageActivity;

public class UserFormPage extends DataGridPageActivity implements PClickHandler {

    private static final String PAGE_NAME = "Create user";
    private StringTextBoxFormField login;
    private StringTextBoxFormField name;
    private PButton create;
    private Form form;

    UserService serviceUser;

    public UserFormPage() {
        super(PAGE_NAME, "Static data");
    }

    @Override
    protected void onInitialization() {}

    @Override
    protected void onFirstShowPage() {

        final PFlowPanel flow = new PFlowPanel();

        // Initialize the formfields
        form = new Form();
        create = new PButton("create1");

        // Add a validator on each formfields to check emptyness
        login = new StringTextBoxFormField();
        login.setValidator(new NotEmptyFieldValidator());
        name = new StringTextBoxFormField();
        name.setValidator(new NotEmptyFieldValidator());
        // Add 2 FormFieldComponent to get the login and the name
        final FormFieldComponent formFieldComponentLogin = new FormFieldComponent(login);
        final FormFieldComponent formFieldComponentName = new FormFieldComponent(name);

        form.addFormField(login);
        form.addFormField(name);

        flow.add(formFieldComponentLogin);
        flow.add(formFieldComponentName);
        flow.add(create);
        create.addClickHandler(this);
        pageView.setWidget(flow);
    }

    @Override
    protected void onShowPage(final Place place) {}

    @Override
    protected void onLeavingPage() {}

    @Override
    public void onClick(final PClickEvent event) {
        if (event.getSource() == create) {
            int i = 0, k = 0;
            for (; i < form.getFormFields().size(); ++i) {
                if (form.getFormFields().get(i).isValid().isValid()) {
                    ++k;
                }
            }
            if (k == form.getFormFields().size()) {
                System.out.println("New USER : (log = " + login.getValue() + " , name = " + name.getValue() + " )");
                final User user = STMessageFactory.newUser();
                user.setLogin(Login.createLogin(login.getValue()));
                user.setName(name.getValue());
                serviceUser = ServiceRegistry.getService(UserService.class);
                serviceUser.createUser(user);
            }
        }
    }
}
