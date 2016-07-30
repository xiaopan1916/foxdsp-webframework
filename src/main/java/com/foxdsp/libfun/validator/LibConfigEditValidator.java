package com.foxdsp.libfun.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.foxdsp.libfun.vo.LibfunCommonReturn;

/**系统配置参数校验
 * Created by briceli
 * on 15/9/9.
 */
public class LibConfigEditValidator extends Validator {
    @Override
    protected void validate(Controller c) {
        validateString("editObj.configno", 1, 30, "errorMsg", "编号长度限制为1-30");
        validateString("editObj.configname", 1, 40, "errorMsg", "名称长度限制为1-40");
        validateString("editObj.configvalue", 1, 100, "errorMsg", "值长度限制为1-100");
    }

    @Override
    protected void handleError(Controller c) {
        c.renderJson(LibfunCommonReturn.genErrorReturn(c.getAttr("errorMsg").toString()));
    }
}
