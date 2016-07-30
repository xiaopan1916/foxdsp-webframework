package com.foxdsp.libfun.util;


import com.jfinal.handler.Handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;


/** 过滤恶意用户输入的攻击脚本，返回安全的字符串
 * Created by panfenquan
 * 2015/11/5
 */
public class XssHandler extends Handler {

    @Override
    public void handle(String target, HttpServletRequest request,
                       HttpServletResponse response, boolean[] isHandled) {
        List<String> excludeUrls = getExcludeUrl();
        if (!excludeUrls.contains(target)) {
            request = new XssHttpServletRequestWrapper(request);
        }
        next.handle(target, request, response, isHandled);
    }

    /**不需要过滤的请求
     * @return list
     */
    private List<String> getExcludeUrl() {
        List<String> excludeUrl = new ArrayList<>();
        excludeUrl.add("/jf/orderMaterial/saveMaterialInfo");
        return excludeUrl;
    }
}


