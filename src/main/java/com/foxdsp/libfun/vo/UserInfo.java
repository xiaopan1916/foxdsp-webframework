/*
 * UserInfo.java
 *
 * Created on 2006年11月3日, 下午6:13
 *
 */

package com.foxdsp.libfun.vo;

import com.foxdsp.libfun.model.Menus;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.constant.LoginStatus;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 记录登陆后，系统用户的基本信息，权限信息，角色信息。
 *
 * @author Brice Li
 */
public class UserInfo {
    /**
     * 在session存放的参数名
     */
    public static final String NAME = "userinfo";
    /**
     * 在session中存放token的参数名
     */
    public static final String TOKEN = "token";

    /**
     * @see LoginStatus
     */
    private int loginStatus = LoginStatus.DEFAULT;

    /**
     * 登录信息
     */
    private String loginMsg;

    private Users user;

    private Map<String, Object> servicePrivilegeMap = new HashMap<String, Object>();

    private List<com.foxdsp.libfun.model.Menus> menus;

    public List<Menus> getMenus() {
        return menus;
    }

    public void setMenus(List<Menus> menus) {
        this.menus = menus;
    }

    private List<String> menunoList = new ArrayList<String>();

    public UserInfo(Users user) {
        super();
        this.user = user;
    }

    @Override
    public String toString() {
        return this.getUserlogno();
    }

    public List<String> getMenunoList() {
        return menunoList;
    }

    public Map<String, Object> getServicePrivilegeMap() {
        return servicePrivilegeMap;
    }

    public String getUserlogno() {
        return user != null ? user.getUserLogNo() : null;
    }

    public int getLoginStatus() {
        return loginStatus;
    }

    public void setLoginStatus(int loginStatus) {
        this.loginStatus = loginStatus;
    }

    public String getLoginMsg() {
        return loginMsg;
    }

    public void setLoginMsg(String loginMsg) {
        this.loginMsg = loginMsg;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }
}
