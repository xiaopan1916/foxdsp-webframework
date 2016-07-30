package com.foxdsp.libfun.constant;

/**
 * Created by panpan
 * on 16/1/19.
 */
public enum UserValidEnum {
    INUSE(1, "有效的"),
    NOT_INUSE(0, "无效的"),;


    private int status;
    private String desc;

    UserValidEnum(int status, String desc) {
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
