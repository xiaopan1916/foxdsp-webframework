package com.foxdsp.libfun.controller;

import com.foxdsp.common.util.io.FileUtil;
import com.jfinal.core.Const;
import com.jfinal.core.Controller;
import com.jfinal.kit.PropKit;
import com.jfinal.upload.UploadFile;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.util.LibFunConfig;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.web.WebApplicationContextUtil;
import com.foxdsp.libfun.vo.UserInfo;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.springframework.context.ApplicationContext;

import java.io.File;

/**
 * Created by briceli on 15/8/21.
 */
public class BaseController extends Controller {

    protected static ApplicationContext ctx = WebApplicationContextUtil.webApplicationContext;
    protected static final int DEFAULT_PAGE_SIZE = 50;

    protected String getQueryPara(String name){
        return this.getPara("_query." + name, "");
    }

    protected String getQueryPara(String name, String defaultValue){
        return this.getPara("_query." + name, defaultValue);
    }

    protected int getQueryParaToInt(String name){
        return this.getParaToInt("_query." + name, 0);
    }

    protected int getQueryParaToInt(String name, int defaultValue){
        return this.getParaToInt("_query." + name, defaultValue);
    }

    protected String getParaAndSet(String name, String defaultValue){
        String rtn = getPara(name, defaultValue);
        setAttr(name, rtn);
        return rtn;
    }

    protected int getParaToIntAndSet(String name, int defaultValue){
        int rtn = getParaToInt(name, defaultValue);
        setAttr(name, rtn);
        return rtn;
    }

    protected LibfunCommonReturn getUploadLibfunCommonReturn() { //通用的上传方法
        //file 是页面上对应的input 名称
        int maxfile = 5 * Const.DEFAULT_MAX_POST_SIZE;
        try  {
            maxfile = LibFunConfig.getIntValue("DEFAULT_MAX_POST_SIZE") ;
            maxfile = maxfile*1024;
        } catch (Exception e) {
            //e.printStackTrace();//TODO 等logger改好后,用logger替换
        }
        boolean success = false ;
        String result = null ;
        try {
            UploadFile fine = getFile("file", PropKit.get("material_upload"),maxfile);
            long millis = System.currentTimeMillis();
            String fileName = millis + "." + FilenameUtils.getExtension(fine.getFileName());
            File destFile = new File( PropKit.get("material_upload") + "/" + fileName );
            FileUtils.copyFile(fine.getFile(),destFile) ;
            if ( destFile.exists() ) {
                success = true ;
                result = fileName;
            }
        } catch (Exception e) {
            e.printStackTrace();
            result = e.getMessage();
        }
        LibfunCommonReturn libfunCommonReturn = new LibfunCommonReturn();
        if ( success ) {
            libfunCommonReturn.setCode(LibfunCommonReturn.CODE_OK);
        } else {
            libfunCommonReturn.setCode(LibfunCommonReturn.CODE_ERROR);
        }
        libfunCommonReturn.setData(result);
        return libfunCommonReturn;
    }

    /**
     * 返回当前登录帐号
     *
     * @return
     */
    protected String currentUserLogo() {
        UserInfo userinfo = currentUserInfo();
        return (userinfo == null) ? null : userinfo.getUserlogno();
    }

    /**
     * 返回当前登录用户信息, 没有则返回null
     *
     * @return UserInfo
     */
    protected UserInfo currentUserInfo() {
        return (UserInfo) getSessionAttr(UserInfo.NAME);
    }

    /**
     * @param userID 该userID用户是否是当前登录用户。
     * @return
     */
    protected boolean isCurrentLogonUser(long userID) {
        UserInfo userInfo = this.currentUserInfo();
        if (userInfo == null
                || userInfo.getUser() == null
                || userInfo.getUser().getSeqId() != userID) {
            // 当前用户没有登陆,或者当前登录用户不是该用户
            return false;
        }
        return true;
    }

    /**
     * 获取登陆用户的信息
     * @return
     */
    public UserInfo getUserInfo() {
        Object userInfo = getSessionAttr(UserInfo.NAME);
        if (userInfo == null) {
            return null;
        }
        return (UserInfo)userInfo;
    }

    /**
     * 获取登陆的用户名称
     * @return
     */
    public String getUserNameLogo() {
        Object userInfo = getSessionAttr(UserInfo.NAME);
        if (userInfo == null) {
            return null;
        }
        for (int i = 0; i <100; i++) {
            System.out.println("什么鬼");
            System.out.println("这个是dev");
        }
        UserInfo info = (UserInfo) userInfo;
        return info.getUserlogno();
    }

    /** 是否是管理员
     * @return
     */
    public boolean isSuperMan() {
        if ( == null) {
            
        }
        UserInfo userInfo = getUserInfo();
        Users user = userInfo.getUser();
        return user.getSuperMan() != 0 ;
    }
}
