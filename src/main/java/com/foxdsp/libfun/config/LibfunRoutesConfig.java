package com.foxdsp.libfun.config;

import com.jfinal.config.Routes;
import com.foxdsp.libfun.controller.*;

/**
 * Created by briceli on 15/8/25.
 */
public class LibfunRoutesConfig extends Routes {

    @Override
    public void config() {
        add("/jf/libfun/libconfig", LibConfigController.class);
        add("/jf/libfun/privilege", PrivilegeController.class);
        add("/jf/libfun/role", RoleController.class);
        add("/jf/libfun/user", UserController.class);
        add("/jf/libfun/menu", MenuController.class);
        add("/jf/libfun/array", LibArrayController.class);
        add("/jf/libfun/arrayItem", LibArrayItemController.class);
        add("/jf/messageList", MessageController.class);
        add("/jf/libfun/syslog",SysLogController.class);
    }
}
