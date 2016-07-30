package com.foxdsp.libfun.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.foxdsp.libfun.vo.LibfunCommonReturn;

/**数组维护子项
 * Created by panfenquan
 * 2015/10/10
 */
public class LibArrayItemValidator extends Validator {

    @Override
    protected void validate(Controller c) {

        validateString("editObj.itemno", 1, 30, "errorMsg", "编号长度限制为1-30");
        validateString("editObj.itemname", 1, 40, "errorMsg", "名称长度限制为1-40");
        validateString("editObj.itemvalue", 1, 100, "errorMsg", "值长度限制为1-100");
        validateString("editObj.itemorder", 1, 100, "errorMsg", "顺序长度限制为1-100");
    }

    @Override
    protected void handleError(Controller c) {
        c.renderJson(LibfunCommonReturn.genErrorReturn(c.getAttr("errorMsg").toString()));
    }
}


