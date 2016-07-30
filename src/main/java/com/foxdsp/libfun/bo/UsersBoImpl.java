
package com.foxdsp.libfun.bo;

import com.foxdsp.common.util.codec.MD5HashUtil;
import com.foxdsp.common.util.lang.StringUtil;
import com.foxdsp.common.util.validate.ValidateUtil;
import com.jfinal.plugin.activerecord.Db;
import com.foxdsp.libfun.constant.LoginStatusEnum;
import com.foxdsp.libfun.constant.UserTypeEnum;
import com.foxdsp.libfun.constant.UserValidEnum;
import com.foxdsp.libfun.model.Role;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.model.Usersrole;
import com.foxdsp.libfun.util.*;
import com.foxdsp.libfun.constant.LoginStatus;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.vo.UserInfo;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author Brice Li
 *
 */
@Component
public class UsersBoImpl  implements IUsersBo {

    @SuppressWarnings("unchecked")
    @Override
    public LibfunCommonReturn login(String userlogo, String password, String ip) {

        Users user = queryUsersByUserLogNo(userlogo);
        UserInfo userinfo = new UserInfo(user);
        if (user == null) {
            userinfo.setLoginStatus(LoginStatus.USERNAME_ERR);
        } else if (!user.isInuse()) {
            userinfo.setLoginStatus(LoginStatus.NOT_INUSE);
        } else if (password != null && !user.getUserPassword().equals(password)) {
            userinfo.setLoginStatus(LoginStatus.PASSWORD_ERR);
        } else {
            userinfo.setLoginStatus(LoginStatus.OK);
        }
        LoginStatusEnum loginStatus = LoginStatusEnum.getLoginStatus(userinfo.getLoginStatus());
        LibfunCommonReturn libfunCommonReturn = new LibfunCommonReturn();
        libfunCommonReturn.setData(userinfo);
        libfunCommonReturn.setCode(loginStatus == null ? LibfunCommonReturn.CODE_ERROR:loginStatus.getStatus());
        libfunCommonReturn.setMessage(loginStatus == null ? "未知错误" : loginStatus.getDesc());

        return libfunCommonReturn;
    }

    public Users queryUsersByUserLogNo(String userlogno) {
        //return utilDao.queryOne(Users.class, "select * from users where userlogno='" + StringUtil.escapeSql(userlogno) + "'");

        return Users.dao.findFirst("select * from libfun_users where userlogno=?", StringUtil.escapeSql(userlogno));
    }


    @Override
    public String updateUser(com.foxdsp.libfun.model.Users users,String superman,String inuse) {
        String seqid = users.getLong("seqid").toString();
        if (StringUtils.isBlank(seqid)) {
            return "请选中列表的一行！";
        }
        com.foxdsp.libfun.model.Users dbUsers = com.foxdsp.libfun.model.Users.dao.findById(seqid);
        if (dbUsers == null) {
            return "用户不存在！";
        }
        String userLogNo = dbUsers.getStr("userlogno");
        if (!StringUtils.equals(userLogNo, users.getStr("userlogno"))) {
            com.foxdsp.libfun.model.Users aUsersdaoFirst = Users.dao.findFirst("select * from users where userlogno = ?",
                    users.getStr("userlogno"));
            if (aUsersdaoFirst != null) {
                return "用户名已经存在";
            }
        }
        if (StringUtils.equals(superman, "on")) {
            users.set("superman", UserTypeEnum.SUPERMAN.getStatus());
        } else {
            users.set("superman", UserTypeEnum.NOT_SUPERMAN.getStatus());
        }
        if (StringUtils.equals(inuse, "on")) {
            users.set("inuse", UserValidEnum.INUSE.getStatus());
        } else {
            users.set("inuse", UserValidEnum.NOT_INUSE.getStatus());
        }
        String userpassword = users.getStr("userpassword");
        if (!StringUtils.equals(userpassword, dbUsers.getStr("userpassword"))) {
            users.set("UserPassword", MD5HashUtil.encryptPwd(users.getStr("userpassword")));
        }
        users.update();
        return null;
    }

    @Override
    public String insertUser(com.foxdsp.libfun.model.Users users,String superman,String inuse) {
        Long count = Db.findFirst("select count(*) as count from libfun_users where UserLogNo = ?",
                users.get("userlogno")).getLong("count");
        if (count > 0) {
            return "用户已经存在！";
        }
        if (StringUtils.equals(superman, "on")) {
            users.set("superman", UserTypeEnum.SUPERMAN.getStatus());
        } else {
            users.set("superman", UserTypeEnum.NOT_SUPERMAN.getStatus());
        }
        if (StringUtils.equals(inuse, "on")) {
            users.set("inuse", UserValidEnum.INUSE.getStatus());
        } else {
            users.set("inuse", UserValidEnum.NOT_INUSE.getStatus());
        }
        users.set("UserPassword", MD5HashUtil.encryptPwd(users.getStr("userpassword")));
        users.save();
        return null;
    }

    @Override
    public List<Role> queryRoleByUserName(String username) {
        return Role.dao.
                find("select r.* from libfun_role r,libfun_usersrole ur where ur.username= ? and ur.roleno=r.no",username);
    }

    @Override
    public List<Role> queryExcludedRoleByUsername(String username) {
        return Role.
                dao.find("select * from libfun_role where no " +
                "not in(select roleno from libfun_usersrole where username=?)",username);
    }

    @Override
    public void insertUserRole(List<Usersrole> usersRoles) {
        if ( usersRoles == null )  {
            return;
        }
        int[] batch = Db.batch("insert into libfun_usersrole(roleno,username) value(?,?) ",
                "roleno,username", usersRoles, usersRoles.size());
    }

    @Override
    public void deleteUserRoleByUsername(List<Usersrole> usersRoles) {
        int[] batch = Db.batch("delete  from libfun_usersrole  where roleno=? and username = ?",
                "roleno,username", usersRoles, usersRoles.size());
    }

    @Override
    public LibfunCommonReturn updateCustomerInfo(String seqid, String email,
                                                 String userpassword, String userName,
                                                 UserInfo userInfo) {
        Users users = Users.dao.findById(seqid);
        if (users == null || !StringUtils.equals(users.getStr("userlogno"), userName)) {
            return  LibfunCommonReturn.genErrorReturn("用户不存在或者您不是当前登录用户");
        }
        Users user = new Users();
        user.set("seqid", seqid);
        if (StringUtils.isNotBlank(email)) {
            String[] emailArray = email.split(",");
            for (String s : emailArray) {
                if( !ValidateUtil.isEmail(s) ) {
                    return LibfunCommonReturn.genErrorReturn(s + "格式不正确");
                }
            }
            user.set("email", email);
        }

        if (StringUtils.isNotBlank(userpassword)) {
            user.set("userpassword", MD5HashUtil.encryptPwd(userpassword));
        }
        user.update();
        userInfo.getUser().setEmail(email);
        return LibfunCommonReturn.genOkReturn();
    }

}
