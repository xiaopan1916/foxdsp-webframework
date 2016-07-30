package com.foxdsp.libfun.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.foxdsp.libfun.vo.LibfunCommonReturn;

/**用户校验
 * Created by panfenquan
 * 2015/9/29
 */
public class UserValidator extends Validator {
    @Override
    protected void validate(Controller c) {
        validateString("editObj.userlogno", 1, 30, "errorMsg", "用户名长度限制为1-30");
        validateString("editObj.userpassword", 1, 40, "errorMsg", "密码不能为空");
        validateString("editObj.truename", 1, 40, "errorMsg", "姓名不能为空");
        validateString("editObj.email", 1, 40, "errorMsg", "邮箱不能为空");
    }

    @Override
    protected void handleError(Controller c) {
        c.renderJson(LibfunCommonReturn.genErrorReturn(c.getAttr("errorMsg").toString()));

    }
}


