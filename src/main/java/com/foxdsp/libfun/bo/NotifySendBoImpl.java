package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.constant.MessageTypeEnum;
import com.foxdsp.libfun.model.Libconfig;
import com.foxdsp.libfun.model.NotifySend;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Map;
import java.util.Set;

/** 发送系统消息
 * Created by panpan
 * on 16/6/21.
 */
@Component
public class NotifySendBoImpl implements NotifySendBo {

    @Autowired
    private NotifyMessageBo notifyMessageBo;

    @Override
    public LibfunCommonReturn addSystemNotify(NotifySend notifySend, boolean isSendTime) {
        Date date = new Date();
        notifySend.setCreatedTime(date);
        notifySend.setEditTime(date);

        if (isSendTime) {
            Date sendTime = notifySend.getSendTime();
            notifySend.setStatus(Boolean.FALSE);
            if (sendTime == null) {
                return LibfunCommonReturn.genErrorReturn("发送时间不能为空!");
            }
        } else {
            sentMessageImmediately(notifySend);
            notifySend.setStatus(Boolean.TRUE);
        }
        notifySend.save();
        return LibfunCommonReturn.genOkReturn();
    }

    private void sentMessageImmediately(NotifySend notifySend) {
        String[] userLogNos = notifySend.getReceiverUserlogno().split(",");
        for (String userLogNo : userLogNos) {
            notifyMessageBo.sendMessage(MessageTypeEnum.SYSTEM_MESSAGE, userLogNo,
                    notifySend.getSenderUserlogno(), notifySend.getTitle(), notifySend.getSendContent(), notifySend.getIsTop());
        }

    }

    @Override
    public LibfunCommonReturn updateNotifySend(NotifySend notifySend, boolean isSendTime) {

        if (notifySend.getSeqid() == null) {
            return LibfunCommonReturn.genErrorReturn("seqid不存在!");
        }
        NotifySend send = NotifySend.dao.findById(notifySend.getSeqid());
        if (send == null) {
            return LibfunCommonReturn.genErrorReturn("记录不存在!");
        }
        if (send.getStatus()) {
            return LibfunCommonReturn.genErrorReturn("消息已经发送,不能更改");
        }
        if (isSendTime) {
            Date sendTime = notifySend.getSendTime();
            if (sendTime == null) {
                return LibfunCommonReturn.genErrorReturn("发送时间不能为空!");
            }
        } else {
            sentMessageImmediately(notifySend);
            notifySend.setStatus(Boolean.TRUE);
        }
        notifySend.setEditTime(new Date());
        notifySend.update();
        return LibfunCommonReturn.genOkReturn();
    }

    @Override
    public LibfunCommonReturn addMessage(MessageTypeEnum messageTypeEnum,
                                         String messageCode, String sender,
                                         String receiver, Map<String, String> map) {

        Libconfig libconfig = Libconfig.dao.findFirst("select * from libfun_libconfig where ConfigNo = ?", messageCode);
        if (libconfig == null) {
            return LibfunCommonReturn.genErrorReturn("模板编码不存在!");
        }
        String configValue = libconfig.getConfigValue();
        Set<String> keySet = map.keySet();
        String content = null;
        for (String s : keySet) {
            content = (StringUtils.isNotBlank(content) ? content : configValue).replace(s, map.get(s));
        }

        boolean sendMessage = notifyMessageBo.sendMessage(messageTypeEnum, receiver, sender,
                libconfig.getConfigName(), content, false);
        if (sendMessage) {
            return LibfunCommonReturn.genOkReturn();
        } else {
            return LibfunCommonReturn.genErrorReturn("消息发送失败!");
        }
    }

    @Override
    public LibfunCommonReturn updateTopStatus(Long seqid, boolean top) {
        if (seqid == null) {
            return LibfunCommonReturn.genErrorReturn("seqid不存在!");
        }
        NotifySend send = NotifySend.dao.findById(seqid);
        if (send == null) {
            return LibfunCommonReturn.genErrorReturn("记录不存在!");
        }
        if (send.getStatus()) {
            return LibfunCommonReturn.genErrorReturn("消息已经发送,不能更改");
        }
        send.setIsTop(top);
        send.update();
        return LibfunCommonReturn.genOkReturn();
    }
}
