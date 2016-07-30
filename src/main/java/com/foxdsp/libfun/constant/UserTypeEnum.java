package com.foxdsp.libfun.constant;

/**
 * Created by panpan
 * on 16/1/19.
 */
public enum UserTypeEnum {

    SUPERMAN(1, "系统管理员"),

    NOT_SUPERMAN(0, "普通");

    private int status;
    private String desc;

    UserTypeEnum(int status, String desc) {
        this.status = status;
        this.desc = desc;
    }

    public int getStatus() {
        return status;
    }

    public String getDesc() {
        return desc;
    }


}
