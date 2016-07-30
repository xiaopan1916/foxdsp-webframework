package com.foxdsp.libfun.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.foxdsp.libfun.vo.LibfunCommonReturn;

/**角色校验
 * Created by panfenquan
 * 2015/9/29
 */
public class RoleValidator extends Validator {
    @Override
    protected void validate(Controller c) {
        validateString("editObj.no", 1, 30, "errorMsg", "编号长度限制为1-30");
        validateString("editObj.name", 1, 40, "errorMsg", "名称长度限制为1-40");
    }

    @Override
    protected void handleError(Controller c) {
        c.renderJson(LibfunCommonReturn.genErrorReturn(c.getAttr("errorMsg").toString()));
    }
}


