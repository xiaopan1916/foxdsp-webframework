package com.foxdsp.libfun.bo;

import com.jfinal.plugin.activerecord.Page;
import com.foxdsp.libfun.constant.MessageTypeEnum;
import com.foxdsp.libfun.model.NotifyMessage;
import com.foxdsp.libfun.vo.MessageCount;

/**
 * Created by panpan
 * on 16/6/21.
 */
public interface NotifyMessageBo {

    /**发送消息
     * @param messageTypeEnum 消息类型
     * @param receiverUserLogNo 接收者
     * @param sendUserLogNo 发送者
     * @param title 标题
     * @param content 内容
     * @param isTop 是否置顶
     */
     boolean sendMessage(MessageTypeEnum messageTypeEnum, String receiverUserLogNo,
                         String sendUserLogNo, String title,
                         String content, boolean isTop);

    /** 根据消息id 读取消息
     * @param messageId 消息id
     * @return 消息
     */
    NotifyMessage readMessageByMessageId(Long messageId);

    /**
     * 根据消息id删除消息(逻辑删除)
     * @param messageId 消息id
     * @return true 成功 ; false 失败
     */
    boolean deleteMessageByMessageId(Long messageId);


    /** 根据消息id 更新已读状态
     * @param messageId 消息id
     * @return true 成功 ; false 失败
     */
    boolean updateMessageReadStatusByMessageId(Long messageId);


    /**获取消息个数
     * @param receiverUserLogNo 接收者
     * @return 个数
     */
    MessageCount countNotReadMessages(String receiverUserLogNo);

    /**
     * @param messageTypeEnum 消息类型
     * @param pageNumber      页码
     * @param receiverUserLogNo 接收用户
     * @return 消息的分页结果
     */
    Page<NotifyMessage> queryMessageByPage(MessageTypeEnum messageTypeEnum, String pageNumber, String receiverUserLogNo);

    /**更新消息的状态为已读
     * @param messageTypeEnum 消息类型
     * @param userLogNo 消息接收者
     */
    void updateMessageReadStatus(MessageTypeEnum messageTypeEnum, String userLogNo);

    /**更新消息的状态为已删除
     * @param messageIds 消息id
     * @param userLogNo 消息接收者
     */
    void updateMessageDeleteStatus(String[] messageIds, String userLogNo);
}
