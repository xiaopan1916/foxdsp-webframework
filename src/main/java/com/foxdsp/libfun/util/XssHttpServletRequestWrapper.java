package com.foxdsp.libfun.util;

import org.jsoup.Jsoup;
import org.jsoup.safety.Whitelist;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/** 重写getParameter、getParameterValues、getParameterMap 的方法，过滤其非法值
 * Created by panfenquan
 * 2015/11/5
 */
public class XssHttpServletRequestWrapper extends HttpServletRequestWrapper {
    /**
     * Constructs a request object wrapping the given request.
     *
     * @param request
     * @throws IllegalArgumentException if the request is null
     */
    public XssHttpServletRequestWrapper(HttpServletRequest request) {
        super(request);
    }
    /**
     *
     */
    @Override
    public String getParameter(String name) {
        return getBasicHtmlAndImage(super.getParameter(name));
    }

    /**
     *
     */
    @Override
    public String[] getParameterValues(String name) {
        String[] values = super.getParameterValues(name);
        if (null == values){
            return null;
        }
        for (int i = 0; i < values.length; i++) {
            values[i] = getBasicHtmlAndImage(values[i]);
        }
        return values;
    }

    /**
     *
     */
    @Override
    public Map getParameterMap() {
        Map paraMap = super.getParameterMap();
        if (null == paraMap || paraMap.isEmpty()) {
            return paraMap;
        }
        Set keySet = paraMap.keySet();
        Object[] objects = keySet.toArray();
        Map map = new HashMap();
        for (Object object : objects) {
            String[] values = ((String[]) paraMap.get(object));
            String[] newValues  = new String[values.length];
            for (int i = 0; i < values.length; i++) {
                newValues[i] = getBasicHtmlAndImage(values[i]);
            }
            map.put(object, newValues);
        }
       return map;
    }

    /**
     * @param html 需要过滤的html
     * @return 过滤之后的字符串
     */
    private String getBasicHtmlAndImage(String html) {
        if (html == null)
            return null;
        String clean = Jsoup.clean(html, Whitelist.basicWithImages());
        return clean;
    }
}


