package com.foxdsp.libfun.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.foxdsp.libfun.vo.LibfunCommonReturn;

/**数组维护参数校验
 * Created by panpan
 * on 15/12/28.
 */
public class LibArrayValidator extends Validator {

    @Override
    protected void validate(Controller c) {
        validateString("editObj.classno", 1, 30, "errorMsg", "编号长度限制为1-30");
        validateString("editObj.classname", 1, 40, "errorMsg", "名称长度限制为1-40");

    }

    @Override
    protected void handleError(Controller c) {
        c.renderJson(LibfunCommonReturn.genErrorReturn(c.getAttr("errorMsg").toString()));
    }
}
