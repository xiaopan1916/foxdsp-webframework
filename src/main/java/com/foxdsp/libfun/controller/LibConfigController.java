package com.foxdsp.libfun.controller;

import com.jfinal.aop.Before;
import com.foxdsp.libfun.bo.LibConfigBo;
import com.foxdsp.libfun.model.Libconfig;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.validator.LibConfigEditValidator;

/**
 * Created by briceli
 * on 15/8/31.
 */
public class LibConfigController extends CrudController<Libconfig> {

    private static LibConfigBo libConfigBo = ctx.getBean(LibConfigBo.class);

    @Override
    public void index() {
        renderFreeMarker("/freemarkerTemplate/libfun/libconfig.ftl");
    }

    @Before(LibConfigEditValidator.class)
    @Override
    public void update() {
        super.update();
    }


    @Before(LibConfigEditValidator.class)
    @Override
    public void insert() {
        Libconfig obj = getModel(Libconfig.class, "editObj");
        LibfunCommonReturn libfunCommonReturn = libConfigBo.insertLibConfig(obj);
        renderJson(libfunCommonReturn);
    }
}
