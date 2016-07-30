package com.foxdsp.libfun.bo;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.foxdsp.libfun.constant.MessageStatus;
import com.foxdsp.libfun.constant.MessageTypeEnum;
import com.foxdsp.libfun.constant.PagingRequest;
import com.foxdsp.libfun.model.BaseModel;
import com.foxdsp.libfun.model.NotifyMessage;
import com.foxdsp.libfun.vo.MessageCount;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by panpan
 * on 16/6/21.
 */
@Component
public class NotifyMessageBoImpl implements NotifyMessageBo {

    @Override
    public boolean sendMessage(MessageTypeEnum messageTypeEnum, String receiverUserLogNo,
                               String sendUserLogNo, String title,
                               String content, boolean isTop) {
        if (messageTypeEnum == null ||
                StringUtils.isBlank(receiverUserLogNo)
                || StringUtils.isBlank(sendUserLogNo) || StringUtils.isBlank(title)
                || StringUtils.isBlank(content)) {
            return false;
        }
        NotifyMessage notifyMessage = new NotifyMessage();
        notifyMessage.setIsTop(isTop);
        notifyMessage.setCreatedTime(new Date());
        notifyMessage.setSenderUserlogno(sendUserLogNo);
        notifyMessage.setReceiverUserlogno(receiverUserLogNo);
        notifyMessage.setMessageContent(content);
        notifyMessage.setTitle(title);
        notifyMessage.setStatus(MessageStatus.NOT_READ.getStatus());
        notifyMessage.setType(messageTypeEnum.getType());
        boolean save = notifyMessage.save();
        return save;
    }

    @Override
    public NotifyMessage readMessageByMessageId(Long messageId) {
        if (messageId == null) {
            return null;
        } else {
            return NotifyMessage.dao.findById(messageId);
        }
    }

    @Override
    public boolean deleteMessageByMessageId(Long messageId) {
        if (messageId == null) {
            return false;
        }
        NotifyMessage notifyMessage = readMessageByMessageId(messageId);
        if (notifyMessage == null) {
            return false;
        }
        if (notifyMessage.getStatus() == MessageStatus.DELETED.getStatus()) {
            return false;
        }
        notifyMessage.setStatus(MessageStatus.DELETED.getStatus());

        return  notifyMessage.update();
    }

    @Override
    public boolean updateMessageReadStatusByMessageId(Long messageId) {
        if (messageId == null) {
            return false;
        }
        NotifyMessage notifyMessage = readMessageByMessageId(messageId);
        if (notifyMessage == null) {
            return false;
        }
        if (notifyMessage.getStatus() == MessageStatus.READ.getStatus()) {
            return false;
        }
        notifyMessage.setStatus(MessageStatus.READ.getStatus());
        return notifyMessage.update();
    }

    @Override
    public MessageCount countNotReadMessages(String receiverUserLogNo) {

        MessageCount count = new MessageCount();
        List<NotifyMessage> messages = NotifyMessage.dao.find("select * from libfun_notify_message where " +
                "status = ? and receiver_userlogno = ?",
               MessageStatus.NOT_READ.getStatus(),receiverUserLogNo);
        count.setTotalCount(messages.size());
        List<NotifyMessage> systemMessages = new ArrayList<>();
        List<NotifyMessage> checkMessages = new ArrayList<>();
        List<NotifyMessage> accountmMessages = new ArrayList<>();
        for (NotifyMessage message : messages) {
            if (message.getType() == MessageTypeEnum.SYSTEM_MESSAGE.getType()) {
                systemMessages.add(message);
            }
            if (message.getType() == MessageTypeEnum.CHECK_MESSAGE.getType()) {
                checkMessages.add(message);
            }
            if (message.getType() == MessageTypeEnum.ACCOUNT_MESSAGE.getType()) {
                accountmMessages.add(message);
            }
        }
        count.setAccountMessageCount(accountmMessages.size());
        count.setCheckMessageCount(checkMessages.size());
        count.setSystemMessageCount(systemMessages.size());
        return count;
    }

    @Override
    public Page<NotifyMessage> queryMessageByPage(MessageTypeEnum messageTypeEnum,
                                                  String pageNumber, String receiverUserLogNo) {
        int pageNo = 1;
        if (StringUtils.isNoneBlank(pageNumber)) {
            pageNo =  Integer.parseInt(pageNumber);
        }
        PagingRequest pagingRequest = new PagingRequest();
        pagingRequest.setPageNumber(pageNo);
        pagingRequest.setPageSize(5);
        Page<NotifyMessage> paginate = NotifyMessage.dao.paginate(pagingRequest.getPageNumber(),
                pagingRequest.getPageSize(), "select *  ", " from libfun_notify_message where type = ? and status != ? and receiver_userlogno =?" +
                        " order by is_top DESC ,created_time DESC ",
                messageTypeEnum.getType(),MessageStatus.DELETED.getStatus(),receiverUserLogNo);
        return paginate;
    }

    @Override
    public void updateMessageReadStatus(MessageTypeEnum messageTypeEnum, String receiverUserLogNo) {
        if (messageTypeEnum == null || StringUtils.isBlank(receiverUserLogNo)) {
            return;
        }
        List<NotifyMessage> notifyMessages = NotifyMessage.dao.find("select * from libfun_notify_message where status = ?" +
                " and  type = ?  and receiver_userlogno = ?",
                MessageStatus.NOT_READ.getStatus(), messageTypeEnum.getType(), receiverUserLogNo);
        if (CollectionUtils.isEmpty(notifyMessages)) {
            return;
        }
        for (NotifyMessage notifyMessage : notifyMessages) {
            notifyMessage.setStatus(MessageStatus.READ.getStatus());
        }
        Db.batchUpdate(notifyMessages, notifyMessages.size());
    }

    @Override
    public void updateMessageDeleteStatus(String[] messageIds, String receiverUserLogNo) {
        if (ArrayUtils.isEmpty(messageIds)) {
            return;
        }
        String sql = "update libfun_notify_message set   status = "+MessageStatus.DELETED.getStatus()+
                " where receiver_userlogno = '"+receiverUserLogNo+"' and seqid in (" + BaseModel.getSQLForIn(messageIds.length) + ")  ";
        Db.update(sql, (Object[]) messageIds);
    }
}
