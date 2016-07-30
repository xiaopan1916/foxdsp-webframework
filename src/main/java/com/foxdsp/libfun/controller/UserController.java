package com.foxdsp.libfun.controller;

import com.foxdsp.common.util.codec.MD5HashUtil;
import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.kit.JsonKit;
import com.foxdsp.libfun.bo.ICommonBo;
import com.foxdsp.libfun.bo.IUsersBo;
import com.foxdsp.libfun.constant.LoginStatusEnum;
import com.foxdsp.libfun.model.*;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.model.Usersrole;
import com.foxdsp.libfun.util.VerifycodeUtil;
import com.foxdsp.libfun.validator.UserValidator;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.vo.UserInfo;
import com.foxdsp.libfun.util.LibFunConfig;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户管理
 * Created by panfenquan
 * 2015/9/29
 */
public class UserController extends CrudController<Users> {

    private static IUsersBo usersBo = ctx.getBean(IUsersBo.class);
    private static ICommonBo commonBo = ctx.getBean(ICommonBo.class);

    @Override
    public void index() {
        renderFreeMarker("/freemarkerTemplate/libfun/user.ftl");
    }

    @Override
    public void delete() {
        super.delete();
    }

    @Override
    @Before(UserValidator.class)
    public void update() {
        Users users = getModel(Users.class, "editObj");
        String superman = "1".equals(users.getSuperMan()+"")?"on":"off";
        String inuse = "1".equals(users.getInUse()+"")?"on":"off";
        String msg = usersBo.updateUser(users,superman,inuse);
        if ( msg != null ) {
            renderJson(LibfunCommonReturn.genErrorReturn(msg));
        } else {
            renderJson(LibfunCommonReturn.genOkReturn());
        }
    }

    @Before(UserValidator.class)
    @Override
    public void insert() {
        Users users = getModel(Users.class, "editObj");
        //String superman = getPara("superman");
        //String inuse = getPara("inuse");
        String superman = "1".equals(users.getSuperMan()+"")?"on":"off";
        String inuse = "1".equals(users.getInUse()+"")?"on":"off";
        String msg = usersBo.insertUser(users,superman,inuse);
        if ( msg != null ) {
            renderJson(LibfunCommonReturn.genErrorReturn(msg));
        } else {
            renderJson(LibfunCommonReturn.genOkReturn());
        }
    }

    @Override
    public void query() {
        super.query();
    }

    /**
     * 查询用户的角色
     */
    public void queryRoleByUserName() {
        String username = getPara("username");
        if (StringUtils.isBlank(username)) {
            renderJson(LibfunCommonReturn.genErrorReturn("用户名为空"));
            return;
        }
        renderJson("data", usersBo.queryRoleByUserName(username));
    }

    /**
     * 用户没有拥有的角色
     */
    public void queryExcludedRoleByUsername() {
        String username = getPara("username");
        if (StringUtils.isBlank(username)) {
            renderJson(LibfunCommonReturn.genErrorReturn("用户名为空"));
            return;
        }
        renderJson("data", usersBo.queryExcludedRoleByUsername(username));
    }

    /**
     * 添加角色
     */
    public void insertUserRole() {
        List<Usersrole> usersRoles = getUsersRoles();
        usersBo.insertUserRole(usersRoles);
        renderJson(LibfunCommonReturn.genOkReturn());

    }

    private List<Usersrole> getUsersRoles() {
        String username = getPara("username");
        if (StringUtils.isBlank(username)) {
            renderJson(LibfunCommonReturn.genErrorReturn("用户名为空"));
            return null;
        }
        String userRole = getPara("userRole");
        if (StringUtils.isBlank(userRole)) {
            renderJson(LibfunCommonReturn.genErrorReturn("请先选择角色"));
            return null;
        }
        String[] strings = userRole.split(",");

        List<Usersrole> usersRoles = new ArrayList<>();
        for (String string : strings) {
            Usersrole usersRole = new Usersrole();
            usersRole.set("roleno", string);
            usersRole.set("username", username);
            usersRoles.add(usersRole);
        }
        return usersRoles;
    }

    /**
     * 删除用户的角色
     */
    public void deleteUserRoleByUsername() {
        List<Usersrole> usersRoles = getUsersRoles();
        usersBo.deleteUserRoleByUsername(usersRoles);
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    /**
     * 用户注销
     */
    @Clear
    public void loginOut() {
        removeSessionAttr(UserInfo.NAME);
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    /**
     * 账号设置
     */
    public void account() {
        UserInfo userInfo = getUserInfo();
        Users users = userInfo.getUser();
        setAttr("users", users);
        String[] emailArray = users.getEmail().split(",");
        setAttr("emailArray", JsonKit.toJson(emailArray));
        Usersext usersExt = Usersext.dao.findFirst("select * from libfun_usersext where usersid= ?" ,users.getSeqId());
        if (usersExt == null) {
            usersExt = new Usersext();
            usersExt.set("usersid", users.getSeqId()).save();
        }
        setAttr("usersExt", usersExt);
        renderFreeMarker("/freemarkerTemplate/libfun/account.ftl");
    }

    /**
     * 登录页面
     */
    @Clear
    public void login() {
        UserInfo userInfo = getUserInfo();
        if (userInfo != null) {
            redirect("dspIndex");
            return;
        }
        boolean verifyCode = LibFunConfig.getBoolean("VerifyCode");
        setAttr("verifyCode", verifyCode);
        renderFreeMarker("/freemarkerTemplate/libfun/login.ftl");
    }

    /**
     * 修改用户信息
     */
    public void updateCustomerInfo() {
        String seqid = getPara("seqid");
        String email = getPara("email");
        String userpassword = getPara("userpassword");
        LibfunCommonReturn libfunCommonReturn =  usersBo.updateCustomerInfo(seqid, email,
                userpassword, getUserNameLogo(), getUserInfo());
        renderJson(libfunCommonReturn);
    }

    /**
     * 修改用户扩展信息
     */
    public void updateUserExt() {
        String seqid = getPara("usersId");
        String pinCiSeQid = getPara("seqid");
        String daily = getPara("daily");
        String weekly = getPara("weekly");
        String activityOver = getPara("activityOver");
        Users users = Users.dao.findById(seqid);
        if (users == null || !StringUtils.equals(users.getStr("userlogno"), getUserNameLogo())) {
            renderJson(LibfunCommonReturn.genErrorReturn("用户不存在或者您不是当前登录用户"));
            return;
        }
        Usersext usersExt = new Usersext();
        usersExt.set("seqid", pinCiSeQid);
        usersExt.set("daily", StringUtils.equals(daily,"true")?1:"");
        usersExt.set("weekly", StringUtils.equals(weekly,"true")?1:"");
        usersExt.set("activityOver", StringUtils.equals(activityOver,"true")?1:"");
        usersExt.update();
        renderJson(LibfunCommonReturn.genOkReturn());

    }
    /**
     * 登录提交
     */
    @Clear
    public void postLogin() {

        String userName = getPara("userName");
        String password = getPara("password");
        String verifyCode = getPara("verifyCode");

        if (LibFunConfig.getBoolean("VerifyCode") && !VerifycodeUtil.isVerify(getRequest(), verifyCode)) {
            renderJson(LibfunCommonReturn.genErrorReturn("亲~验证码错误"));
            return;
        }
        LibfunCommonReturn libfunCommonReturn = commonBo.login(userName, MD5HashUtil.encryptPwd(password),
                getRequest().getRemoteAddr());

        UserInfo userInfo = (UserInfo)libfunCommonReturn.getData();

        if (userInfo != null && userInfo.getLoginStatus() == LoginStatusEnum.OK.getStatus()) {
            setSessionAttr("userinfo", userInfo);
            renderJson(LibfunCommonReturn.genOkReturn());
        } else {
            renderJson(LibfunCommonReturn.genErrorReturn(libfunCommonReturn.getMessage()));
        }
    }
    /**
     * dsp 的首页
     */
    public void dspIndex() {
        renderFreeMarker("/freemarkerTemplate/libfun/index.ftl");
    }
}


