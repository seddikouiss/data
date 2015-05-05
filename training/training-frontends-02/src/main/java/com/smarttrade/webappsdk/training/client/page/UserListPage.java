
package com.smarttrade.webappsdk.training.client.page;

import java.util.List;

import com.ponysdk.core.place.Place;
import com.ponysdk.core.query.Query;
import com.ponysdk.core.query.Result;
import com.ponysdk.ui.server.list2.DataGridColumnDescriptor;
import com.ponysdk.ui.server.list2.renderer.cell.LabelCellRenderer;
import com.ponysdk.ui.server.list2.renderer.header.StringHeaderCellRenderer;
import com.ponysdk.ui.server.list2.valueprovider.ValueProvider;
import com.smarttrade.messages.structures.User;
import com.smarttrade.webappsdk.services.ServiceRegistry;
import com.smarttrade.webappsdk.training.service.user.UserService;
import com.smarttrade.webappsdk.widgets.datagrid.DataGrid;
import com.smarttrade.webappsdk.widgets.datagrid.DataGridPageActivity;
import com.smarttrade.webappsdk.widgets.datagrid.DataProvider;

public class UserListPage extends DataGridPageActivity implements DataProvider<User> {

    private static final String PAGE_NAME = "Users";
    private DataGrid<User> grid;
    UserService serviceUser;

    public UserListPage() {
        super(PAGE_NAME, "Static data");
    }

    @Override
    protected void onInitialization() {}

    @Override
    protected void onFirstShowPage() {

        grid = new DataGrid<User>(PAGE_NAME, this);
        final DataGridColumnDescriptor<User, String> dataGridColumnDescLogin = new DataGridColumnDescriptor<User, String>();
        dataGridColumnDescLogin.setCellRenderer(new LabelCellRenderer<String>());
        dataGridColumnDescLogin.setHeaderCellRenderer(new StringHeaderCellRenderer("Login"));
        dataGridColumnDescLogin.setValueProvider(new ValueProvider<User, String>() {

            @Override
            public String getValue(final User data) {
                return data.getLogin().toString();
            }
        });
        final DataGridColumnDescriptor<User, String> dataGridColumnDescName = new DataGridColumnDescriptor<User, String>();
        dataGridColumnDescName.setCellRenderer(new LabelCellRenderer<String>());
        dataGridColumnDescName.setHeaderCellRenderer(new StringHeaderCellRenderer("Name"));
        dataGridColumnDescName.setValueProvider(new ValueProvider<User, String>() {

            @Override
            public String getValue(final User data) {
                return data.getName();
            }
        });

        // Add a column to display the login of the user
        // Add a column to display the name of the user
        // Use DataGridColumnDescriptor to define the header / value provider / cell rendrer

        grid.addColumn(PAGE_NAME, dataGridColumnDescLogin);
        grid.addColumn(PAGE_NAME, dataGridColumnDescName);

        pageView.setWidget(grid);

    }

    @Override
    protected void onShowPage(final Place place) {
        grid.show(Place.NOWHERE); // to refresh the list
    }

    @Override
    protected void onLeavingPage() {}

    @Override
    public Result<List<User>> getData(final Query query) {
        serviceUser = ServiceRegistry.getService(UserService.class);
        return new Result<List<User>>(serviceUser.findAll());
    }

}
