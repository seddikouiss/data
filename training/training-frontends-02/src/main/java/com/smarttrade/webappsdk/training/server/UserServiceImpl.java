
package com.smarttrade.webappsdk.training.server;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.ponysdk.core.query.Query;
import com.smarttrade.messages.structures.User;
import com.smarttrade.webappsdk.core.shared.query.SearchResult;
import com.smarttrade.webappsdk.training.service.user.UserService;

public class UserServiceImpl implements UserService {

    private final Map<String, User> users = new ConcurrentHashMap<String, User>();

    // Data static
    @Override
    public SearchResult<User> findUser(final Query query) {

        // final SearchResult<User> ret = new SearchResult<User>();
        // final List<User> lstResult = new ArrayList<User>();
        // final User u = STMessageFactory.newUser();
        //
        // u.setUserID(UserID.createUserID("100"));
        // u.setName("seddik");
        // lstResult.add(u);
        // ret.setData(lstResult);
        //
        // return ret;
        return null;
    }

    @Override
    public void createUser(final User user) {
        users.put(user.getLogin().getValue(), user);
        System.out.println("createUser() -> size : " + users.size());
    }

    @Override
    public List<User> findAll() {
        return new ArrayList<User>(users.values());
    }

}
