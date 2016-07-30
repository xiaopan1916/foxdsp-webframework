package com.foxdsp.libfun.validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;
import com.foxdsp.libfun.vo.LibfunCommonReturn;

/** 消息验证
 * Created by panpan
 * on 16/6/28.
 */
public class MessageValidator extends Validator {
    @Override
    protected void validate(Controller c) {
        validateRequired("editObj.receiver_userlogno", "errorMsg", "接收账号为空!");
        validateString("editObj.title", 4, 20, "errorMsg", "标题长度为4~20个字符!");
        validateString("editObj.send_content", 4, 250, "errorMsg", "内容长度为4~250个字符!");
    }

    @Override
    protected void handleError(Controller c) {
        c.renderJson(LibfunCommonReturn.genErrorReturn(c.getAttr("errorMsg").toString()));
    }
}
