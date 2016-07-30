package com.foxdsp.libfun.vo;

/**
 * 消息的数量
 * Created by panpan
 * on 16/6/24.
 */
public class MessageCount {

    /**
     * 系统消息的数量
     */
    private int systemMessageCount;

    /**
     * 审核消息的数量
     */
    private int checkMessageCount;

    /**
     * 账户消息的数量
     */
    private int accountMessageCount;

    /**
     * 总消息的数量
     */
    private int totalCount;

    public int getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }

    public int getAccountMessageCount() {
        return accountMessageCount;
    }

    public void setAccountMessageCount(int accountMessageCount) {
        this.accountMessageCount = accountMessageCount;
    }

    public int getCheckMessageCount() {
        return checkMessageCount;
    }

    public void setCheckMessageCount(int checkMessageCount) {
        this.checkMessageCount = checkMessageCount;
    }

    public int getSystemMessageCount() {
        return systemMessageCount;
    }

    public void setSystemMessageCount(int systemMessageCount) {
        this.systemMessageCount = systemMessageCount;
    }

}
