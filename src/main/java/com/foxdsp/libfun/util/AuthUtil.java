package com.foxdsp.libfun.util;

import com.foxdsp.libfun.vo.UserInfo;
import org.apache.commons.lang3.StringUtils;

/** 权限判断工具类
 * 此类是方便在freemarker 页面中使用。调用方法如下：
 *  <#if  authUtil.hasPrivilege("jf/orderInfo") >
 *</#if>
 *
 * Created by panfenquan
 * 2015/9/18
 */
public class AuthUtil  {

    private UserInfo userInfo;

    public static final String AUTH_NAME = "foxdsp-";

    public AuthUtil(UserInfo userInfo) {
        this.userInfo = userInfo;
    }

    /** 判断是否拥有权限
     * @param key 权限key
     * @return
     */
    public boolean hasPrivilege(String key) {
        if (StringUtils.isBlank(key)) {
            return false;
        }

        if (userInfo == null) {
            return false;
        }
        boolean superman = userInfo.getUser().isSuperman();
        if (superman) {
            return true;
        }
        Object privilege = userInfo.getServicePrivilegeMap().get(AUTH_NAME + key);
        if (privilege == null) {
            return false;
        }
        return true;
    }

}


