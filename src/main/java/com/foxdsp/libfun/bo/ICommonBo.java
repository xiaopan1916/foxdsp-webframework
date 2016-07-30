package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.model.Menus;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.vo.UserInfo;

import java.util.List;
import java.util.Map;

/**
 * @author liheng
 * @since 2011-10-27 上午11:19:36
 */
public interface ICommonBo {

    /**
     * 获得系统配置
     *
     * @return
     */
    public LibfunCommonReturn getConfig();


    /**
     * 检查用户是否已经登录
     * @return
     */
    //public UserInfo hasLogin();

    /**
     * 用户注销
     */
    public void logout();

    /**
     * 获得当前用户菜单
     *
     * @return
     */
    public List<Menus> getMenus(UserInfo userInfo);

    boolean  hasPrivilege(UserInfo userInfo, String serviceName, String methodName);

    /**
     * 获取全局的用户登陆记录
     */
    public Map<String, Object> getUserMap();

    /**
     * 重置密码
     *
     * @param username
     * @return
     */
    public String resetPasswordByUsername(String username);

    /**
     * 登录获取相关的登录信息
     *
     * @param username 用户名称
     * @param password 密码
     * @param ip IP 地址
     * @return
     */
    public LibfunCommonReturn login(String username, String password, String ip);
}
