package com.foxdsp.libfun.constant;

/**
 * 消息的状态
 * Created by panpan
 * on 16/6/21.
 */
public enum MessageStatus {
    NOT_READ(0, "未读"),
    READ(1, "已读"),
    DELETED(2,"已删除")
    ;


    private int status;
    private String desc;

    MessageStatus(int status, String desc) {
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
