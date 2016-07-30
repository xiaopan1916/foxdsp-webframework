package com.foxdsp.libfun.controller;

import com.jfinal.aop.Before;
import com.foxdsp.libfun.bo.LibArrayBo;
import com.foxdsp.libfun.model.Libclassd;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.validator.LibArrayItemValidator;

/**
 * 数组维护子项
 * Created by panfenquan
 * 2015/10/9
 */
public class LibArrayItemController extends CrudController<Libclassd> {

    private static LibArrayBo libArrayBo = ctx.getBean(LibArrayBo.class);


    @Override
    public void index() {
        String classNo = getPara("classNo");
        setAttr("classNo", classNo);
        renderFreeMarker("/freemarkerTemplate/libfun/arrayItem.ftl");
    }

    @Override
    public void delete() {
        super.delete();
    }

    @Before(LibArrayItemValidator.class)
    @Override
    public void update() {
        Libclassd libClassD = getModel(Libclassd.class, "editObj");
        LibfunCommonReturn libfunCommonReturn = libArrayBo.updateArrayItem(libClassD, getUserNameLogo());
        renderJson(libfunCommonReturn);
    }

    @Before(LibArrayItemValidator.class)
    @Override
    public void insert() {
        Libclassd libClassD = getModel(Libclassd.class, "editObj");
        LibfunCommonReturn libfunCommonReturn = libArrayBo.insertArrayItem(libClassD, getUserNameLogo());
        renderJson(libfunCommonReturn);
    }

    @Override
    public void query() {
        super.query();
    }
}


