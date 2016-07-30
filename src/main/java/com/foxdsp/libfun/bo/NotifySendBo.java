package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.constant.MessageTypeEnum;
import com.foxdsp.libfun.model.NotifySend;
import com.foxdsp.libfun.vo.LibfunCommonReturn;

import java.util.Map;

/**消息发送接口
 * Created by panpan
 * on 16/6/21.
 */
public interface NotifySendBo {

    /**
     * 添加系统消息发送
     *
     * @param notifySend 发送任务
     * @param isSendTime 是否定时发送
     * @return 成功或者失败
     */
    LibfunCommonReturn addSystemNotify(NotifySend notifySend, boolean isSendTime);


    /**更新消息发送
     * @param notifySend 消息发送
     * @param isSendTime 是否定时发送
     * @return 成功或者失败
     */
    LibfunCommonReturn updateNotifySend(NotifySend notifySend, boolean isSendTime);


    /** 发送(账户消息、审核消息)
     * @param messageTypeEnum 消息类型
     * @param messageCode 消息码
     * @param sender 发送者
     * @param receiver 接收者
     * @param map 发送内容 map
     * @return 成功或者失败
     */
    LibfunCommonReturn addMessage(MessageTypeEnum messageTypeEnum,
                                  String messageCode, String sender, String receiver, Map<String, String> map);

    /** 更新置顶状态
     * @param seqid id
     * @param top 置顶
     * @return 成功或者失败
     */
    LibfunCommonReturn updateTopStatus(Long seqid, boolean top);
}
