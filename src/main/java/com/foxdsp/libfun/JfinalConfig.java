package com.foxdsp.libfun;

import com.foxdsp.libfun.util.ThreadSysLog;
import com.jfinal.config.*;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.ViewType;
import com.foxdsp.libfun.config.LibfunModelConfig;
import com.foxdsp.libfun.config.LibfunRoutesConfig;
import com.foxdsp.libfun.interceptor.AuthInterceptor;
import com.foxdsp.libfun.util.XssHandler;

/**
 * Created by briceli on 15/8/21.
 */
public class JfinalConfig extends JFinalConfig {

    @Override
    public void configConstant(Constants constants) {
        PropKit.use("config.properties");
        //loadPropertyFile("config.properties");
        constants.setDevMode(PropKit.getBoolean("libfun.devMode"));
        constants.setViewType(ViewType.FREE_MARKER);
        constants.setError404View("/freemarkerTemplate/common/404.ftl");
        constants.setError500View("/freemarkerTemplate/common/500.ftl");
        constants.setBaseUploadPath("/");
    }

    @Override
    public void configRoute(Routes routes) {
        routes.add(new LibfunRoutesConfig());
    }

    @Override
    public void configPlugin(Plugins plugins) {
        //loadPropertyFile("config.properties");
        C3p0Plugin c3p0Plugin = new C3p0Plugin("jdbc:mysql://" + PropKit.get("libfun.mysql.host") + ":" + PropKit.get("libfun.mysql.port") + "/" + PropKit.get("libfun.mysql.db") + "?characterEncoding=utf8&autoReconnect=true", PropKit.get("libfun.mysql.user"), PropKit.get("libfun.mysql.password"));
        plugins.add(c3p0Plugin);
        plugins.add(getActiveRecordPlugin(c3p0Plugin));
        plugins.add(new EhCachePlugin());
    }

    public static ActiveRecordPlugin getActiveRecordPlugin(C3p0Plugin c3p0Plugin) {
        ActiveRecordPlugin arp = new ActiveRecordPlugin(c3p0Plugin);
        arp.setShowSql(PropKit.getBoolean("libfun.devMode"));
        arp.setContainerFactory(new CaseInsensitiveContainerFactory(true));
        LibfunModelConfig.mapModel(arp);
        return arp ;
    }

    @Override
    public void configInterceptor(Interceptors interceptors) {
        interceptors.add(new AuthInterceptor());
    }

    @Override
    public void configHandler(Handlers handlers) {
        handlers.add(new XssHandler());
        //handlers.add(new UrlSkipHandler("/ws/*",false) );//跳过该目录

    }

    @Override
    public void afterJFinalStart() {
        ThreadSysLog.startSaveDBThread();
    }
}
