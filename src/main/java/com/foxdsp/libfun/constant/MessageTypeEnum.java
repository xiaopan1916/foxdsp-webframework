package com.foxdsp.libfun.constant;

/**消息类型
 * Created by panpan
 * on 16/6/21.
 */
public enum  MessageTypeEnum {
    SYSTEM_MESSAGE(0,"系统消息"),
    CHECK_MESSAGE(1,"审核消息"),
    ACCOUNT_MESSAGE(2, "账户消息")
    ;

    private int type;
    private String desc;

    MessageTypeEnum(int type, String desc) {
        this.type = type;
        this.desc = desc;
    }

    public static MessageTypeEnum getMessageTypeEnum(int type) {
        MessageTypeEnum[] values = MessageTypeEnum.values();
        for (MessageTypeEnum value : values) {
            if (value.getType() == type) {
                return value;
            }
        }
        return null;
    }
    public int getType() {
        return type;
    }

    public String getDesc() {
        return desc;
    }
}
