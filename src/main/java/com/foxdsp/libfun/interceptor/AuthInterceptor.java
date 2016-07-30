package com.foxdsp.libfun.interceptor;

import com.foxdsp.common.util.StacktraceUtil;
import com.foxdsp.libfun.util.ThreadSysLog;
import com.foxdsp.libfun.model.Syslog;
import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;
import com.jfinal.core.Controller;
//import com.jfinal.log.Logger;
import com.jfinal.log.Log;
import com.jfinal.render.FreeMarkerRender;
import com.foxdsp.libfun.util.LoggerUtil;
import com.foxdsp.libfun.util.UserAuthUtil;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.vo.UserInfo;
import freemarker.template.TemplateModelException;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.regex.Pattern;


/**
 * 权限拦截器
 * <p/>
 * 鉴于迅雷采用的是名称+值 作为权限key 的方式匹配用户拥有的权限，
 * 现权限管理配置的约定：
 * 新版DSP权限管理配置： 名称统一为 : foxdsp ,值为：url （不包含参数，如 ： /jf/orderInfo/genernalInfo?orderId=68484，url 配置为 /jf/orderInfo/genernalInfo）
 * 如果需要在某一个页面作权限判断，可使用 AuthUtil 工具类处理
 * Created by panfenquan
 * 2015/9/18
 */
public class AuthInterceptor implements Interceptor {

    private static final Log log = Log.getLog(AuthInterceptor.class);
    private static final Pattern IP_PATTERN = Pattern.compile("^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$");

    @Override
    public void intercept(Invocation inv) {
        Controller controller = inv.getController();
        String path = inv.getActionKey();

        Object userInfoObj = controller.getSessionAttr(UserInfo.NAME);
        UserInfo userInfo = userInfoObj == null ? null : (UserInfo) userInfoObj;

//
//        String para = controller.getPara();
//        System.out.println(para);

        if (userInfoObj == null) {
            //没有登录
            controller.redirect("/jf/libfun/user/login?path=" + path, true);
        } else {
            if (UserAuthUtil.me.authPathByUser(path, userInfo) || UserAuthUtil.me.authPathByUser(path+"/index", userInfo) || "/jf/libfun/user/dspIndex".equals(path)) {
                com.foxdsp.libfun.util.AuthUtil authUtil = new com.foxdsp.libfun.util.AuthUtil(userInfo);
                try {
                    FreeMarkerRender.getConfiguration().setSharedVariable("authUtil", authUtil);
                } catch (TemplateModelException e) {
                    log.error("authUtil 类出现异常",e);
                }
                controller.setAttr("userName", userInfo.getUserlogno());
                controller.setAttr("menus", userInfo.getMenus());
                long start = System.currentTimeMillis();
                try {
                    inv.invoke();

                    long executeTime = System.currentTimeMillis() - start;
                    addSysLog(controller, userInfo, executeTime, path);
                    LoggerUtil.info("methodProfile->{}->{}",path,executeTime);
                } catch (Exception e) {
                    e.printStackTrace();
                    String error = formatStackTrace(e);
                    //错误信息单独放到一个文件
                    LoggerUtil.error("exception->{}", error);
                    System.out.println(error);
                    controller.renderJson(LibfunCommonReturn.genErrorReturn(error));
//                  controller.setAttr("message",formatStackTrace(e));
//                  controller.renderFreeMarker("/freemarkerTemplate/common/error.ftl");
                }
            } else {
                //没权限
                LoggerUtil.warn("privilege->{}->{}", userInfo.getUserlogno(),path);
                controller.setAttr("message", "您没有此模块权限");
                controller.render("/freemarkerTemplate/common/error.ftl");
            }
        }
    }

    private void addSysLog(Controller controller, UserInfo userInfo, long executeTime, String path) {
        HttpServletRequest request = controller.getRequest();
        Syslog syslog = new Syslog();
        syslog.setIp(getIp(request));
        syslog.setMethod(request.getMethod());
        syslog.setUrl(path);
        syslog.setUserlogno(userInfo.getUserlogno());
        syslog.setVisitTime(new Date());
        syslog.setTime(executeTime);
        ThreadSysLog.add(syslog);
    }


    private static String formatStackTrace(Throwable throwable) {
        if (throwable == null) {
            return "";
        }
        return StacktraceUtil.printThrowable(throwable).toString();
    }

    /**
     * 通过HttpServletRequest获取IP
     *
     * @param request
     * @return
     */
    public static String getIp(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip != null  && IP_PATTERN.matcher(ip).matches()) {
            return ip;
        }
        String realIp = request.getHeader("X-Real-IP");
        if (realIp != null && IP_PATTERN.matcher(realIp).matches()) {
            return realIp;
        }

        return request.getRemoteAddr();
    }
}


