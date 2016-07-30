package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.model.Role;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.model.Usersrole;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.vo.UserInfo;


import java.util.List;

/**
 * 系统用户模块的业务接口
 *
 * @author Brice Li
 */
public interface IUsersBo{

    /**
     * 登录系统
     * @param userlogo
     * @param password
     * @param ip
     */
    public LibfunCommonReturn login(String userlogo, String password,
                                    String ip);

    /**
     * 查找用户信息
     * @param userlogno
     * @return
     */
    public Users queryUsersByUserLogNo(String userlogno);


    String updateUser(com.foxdsp.libfun.model.Users users, String superman, String inuse);

    String insertUser(com.foxdsp.libfun.model.Users users, String superman, String inuse);

    List<Role> queryRoleByUserName(String username);

    List<Role> queryExcludedRoleByUsername(String username);

    void insertUserRole(List<Usersrole> usersRoles);


    void deleteUserRoleByUsername(List<Usersrole> usersRoles);

    /** 修改用户信息
     * @param seqid seqid
     * @param email 邮箱
     * @param userpassword 密码
     * @param userName 用户名
     * @param userInfo 用户信息
     * @return 失败的结果或者成功的结果
     */
    LibfunCommonReturn updateCustomerInfo(String seqid, String email,
                                          String userpassword,
                                          String userName, UserInfo userInfo);
}
