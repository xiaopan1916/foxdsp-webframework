package com.foxdsp.libfun.vo;

import com.jfinal.plugin.activerecord.Page;
import com.foxdsp.libfun.model.NotifyMessage;

/**
 * Created by panpan
 * on 16/6/24.
 */
public class MessageInfoAndCount {

    private Page<NotifyMessage> paging;
    private MessageCount messageCount;

    public Page<NotifyMessage> getPaging() {
        return paging;
    }

    public void setPaging(Page<NotifyMessage> paging) {
        this.paging = paging;
    }

    public MessageCount getMessageCount() {
        return messageCount;
    }

    public void setMessageCount(MessageCount messageCount) {
        this.messageCount = messageCount;
    }
}
