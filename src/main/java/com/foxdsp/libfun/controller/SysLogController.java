package com.foxdsp.libfun.controller;

import com.foxdsp.libfun.model.Syslog;

/** 系统日志
 * Created by panpan
 * on 16/7/12.
 */
public class SysLogController extends CrudController<Syslog> {
    @Override
    public void index() {
        renderFreeMarker("/freemarkerTemplate/libfun/syslog.ftl");
    }

}
