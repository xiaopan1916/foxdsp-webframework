package com.foxdsp.libfun.controller;

import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.foxdsp.libfun.bo.LibArrayBo;
import com.foxdsp.libfun.model.Libclassm;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.validator.LibArrayValidator;

/**
 * 数组维护
 * Created by panfenquan
 * 2015/10/9
 */
public class LibArrayController extends CrudController<Libclassm> {

    private static LibArrayBo libArrayBo = ctx.getBean(LibArrayBo.class);

    @Override
    public void index() {
        renderFreeMarker("/freemarkerTemplate/libfun/libArray.ftl");
    }

    @Before(Tx.class)
    @Override
    public void delete() {
        String classno = getPara("classno");
        LibfunCommonReturn libfunCommonReturn = libArrayBo.deleteLibArray(classno);
        renderJson(libfunCommonReturn);
    }

    @Before(LibArrayValidator.class)
    @Override
    public void update() {
        Libclassm libClassM = getModel(Libclassm.class, "editObj");
        LibfunCommonReturn libfunCommonReturn = libArrayBo.updateLibArray(libClassM);
        renderJson(libfunCommonReturn);
    }

    @Before(LibArrayValidator.class)
    @Override
    public void insert() {
        Libclassm libClassM = getModel(Libclassm.class, "editObj");
        LibfunCommonReturn libfunCommonReturn = libArrayBo.insertLibArray(libClassM);
        renderJson(libfunCommonReturn);
    }

    @Override
    public void query() {
        super.query();
    }
}


