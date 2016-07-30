package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.constant.MessageTypeEnum;
import com.foxdsp.libfun.model.NotifySend;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.List;

/**每五分钟检测发送消息
 * Created by panpan
 * on 16/6/21.
 */
@Component
public class SendMessageTaskImpl implements SendMessageTask {

    private static final int NO_SEND = 0;

    @Autowired
    private NotifyMessageBo notifyMessageBo;

    @Scheduled(cron = "0 0/5 *  * * ? ")
    @Override
    public void timeToSend() {
        List<NotifySend> notifySends = NotifySend.dao.find("select * from libfun_notify_send where status = ?", NO_SEND);
        if (CollectionUtils.isEmpty(notifySends)) {
            return;
        }
        Date date = new Date();
        for (NotifySend notifySend : notifySends) {
            Date sendTime = notifySend.getSendTime();
            if (sendTime == null || date.compareTo(sendTime) < 0) {
                continue;
            }
            String[] userLogNos = notifySend.getReceiverUserlogno().split(",");
            for (String userLogNo : userLogNos) {
                notifyMessageBo.sendMessage(MessageTypeEnum.SYSTEM_MESSAGE, userLogNo, notifySend.getSenderUserlogno(),
                        notifySend.getTitle(), notifySend.getSendContent(), notifySend.getIsTop());
            }
            notifySend.setStatus(Boolean.TRUE);
            notifySend.update();
        }


    }
}
