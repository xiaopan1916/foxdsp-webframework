package com.foxdsp.libfun.constant;

/** 登录
 * Created by panfenquan
 * 2015/10/15
 */
public enum LoginStatusEnum {

    USERNAME_ERR(3,"用户名错误"),
    IP_ERR(4,"IP错误"),
    PASSWORD_ERR(5,"密码错误"),
    NOT_INUSE(6,"用户失效"),
    EXPIRE(7, "用户过期"),
    VERIFY_CODE_ERR(8, "验证码错误"),
    OK(0, "成功")
    ;


    private int status;
    private String desc;

    LoginStatusEnum(int status, String desc) {
        this.status = status;
        this.desc = desc;
    }

    public static LoginStatusEnum getLoginStatus(int status) {
        LoginStatusEnum[] values = LoginStatusEnum.values();
        for (LoginStatusEnum value : values) {
            if (status == value.getStatus()) {
                return value;
            }
        }
        return null;
    }
    public int getStatus() {
        return status;
    }

    public String getDesc() {
        return desc;
    }
}
