package com.foxdsp.libfun.bo;

import com.BaseTest;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;
import com.foxdsp.libfun.constant.MessageStatus;
import com.foxdsp.libfun.constant.MessageTypeEnum;
import com.foxdsp.libfun.model.NotifyMessage;
import com.foxdsp.libfun.model.NotifySend;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.Assert;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

/**
 * 消息测试
 * Created by panpan
 * on 16/6/25.
 */
public class MessageTest extends BaseTest {

    @Autowired
    private NotifySendBo notifySendBo;

    @Autowired
    private NotifyMessageBo notifyMessageBo;

    /**
     * 审核消息、账户消息的测试
     *
     * @throws Exception
     */
    @Test
    public void testSendCheckMessage() throws Exception {
        Db.tx(new IAtom() {
                    @Override
                    public boolean run() throws SQLException {
                        // 审核消息
                        HashMap<String, String> objectObjectHashMap = new HashMap<>();
                        String testName1 = "testname1";
                        objectObjectHashMap.put("${userLogNo}", testName1);
                        objectObjectHashMap.put("${advertisers}", "我是很大的广告主");
                        LibfunCommonReturn libfunCommonReturn = notifySendBo.addMessage(MessageTypeEnum.CHECK_MESSAGE,
                                "qualification_not_pass", "系统管理员", testName1, objectObjectHashMap);
                        Assert.isTrue(libfunCommonReturn.getCode() == LibfunCommonReturn.CODE_OK);
                        NotifyMessage notifyMessage = NotifyMessage.dao.findFirst("select * from libfun_notify_message where receiver_userlogno = ? and type = ?",
                                testName1, MessageTypeEnum.CHECK_MESSAGE.getType());
                        Assert.notNull(notifyMessage);

                        Assert.isTrue(notifyMessage.getSenderUserlogno().equals("系统管理员"));

                        // 账户消息
                        HashMap<String, String> accountMap = new HashMap<>();
                        String testName2 = "testName2";
                        accountMap.put("${userLogNo}", testName2);
                        accountMap.put("${money}", "210");
                        LibfunCommonReturn commonReturn = notifySendBo.addMessage(MessageTypeEnum.ACCOUNT_MESSAGE,
                                "recharge_message", "系统自动发送", testName2, accountMap);
                        Assert.isTrue(commonReturn.getCode() == LibfunCommonReturn.CODE_OK);

                        NotifyMessage notifyMessage2 = NotifyMessage.dao.findFirst("select * from libfun_notify_message where receiver_userlogno = ? and type = ?",
                                testName2, MessageTypeEnum.ACCOUNT_MESSAGE.getType());
                        Assert.notNull(notifyMessage2);

                        Assert.isTrue(notifyMessage2.getSenderUserlogno().equals("系统自动发送"));
                        return false;
                    }
                });


    }


    /**
     * 添加系统消息任务 测试
     *
     * @throws Exception
     */
    @Test
    public void addSystemNotifyTest() throws Exception {
        Db.tx(new IAtom() {
                    @Override
                    public boolean run() throws SQLException {
                        // 立即发送 成功
                        NotifySend notifySend = getNotifySend();
                        boolean isSentTime = false;
                        LibfunCommonReturn libfunCommonReturn = notifySendBo.addSystemNotify(notifySend, isSentTime);
                        Assert.isTrue(libfunCommonReturn.getCode() == LibfunCommonReturn.CODE_OK);
                        NotifySend notifySend1 = NotifySend.dao.findFirst("select * from libfun_notify_send where title = ?", notifySend.getTitle());
                        Assert.notNull(notifySend1);
                        Assert.isTrue(notifySend1.getStatus());

                        NotifyMessage notifyMessage = NotifyMessage.dao.findFirst("select * from libfun_notify_message where receiver_userlogno = ?", "testname1");

                        Assert.notNull(notifyMessage);

                        NotifyMessage notifyMessage2 = NotifyMessage.dao.findFirst("select * from libfun_notify_message where receiver_userlogno = ?", "testname2");
                        Assert.notNull(notifyMessage2);


                        // 定时时间为空

                        NotifySend notifySend4 = new NotifySend();
                        notifySend4.setTitle("这个是标题");
                        notifySend4.setSendContent("这里是测试内容");
                        notifySend4.setSenderUserlogno("sender");
                        notifySend4.setIsTop(Boolean.TRUE);
                        notifySend4.setReceiverUserlogno("testname4");
                        notifySend4.setSendTime(new Date());
                        LibfunCommonReturn libfunCommonReturn4 = notifySendBo.addSystemNotify(notifySend4, true);
                        Assert.isTrue(libfunCommonReturn4.getCode() == LibfunCommonReturn.CODE_OK);
                        NotifySend notifySend5 = NotifySend.dao.findFirst("select * from libfun_notify_send where title = ?", notifySend4.getTitle());
                        Assert.notNull(notifySend5);
                        Assert.isTrue(!notifySend5.getStatus());

                        return false;
                    }
                });

    }

    /** 更新为已删除状态
     * @throws Exception
     */
    @Test
    public void testMessageDeleteStatus() throws Exception {
        Db.tx(new IAtom() {
            @Override
            public boolean run() throws SQLException {

                NotifySend notifySend = getNotifySend();
                LibfunCommonReturn libfunCommonReturn = notifySendBo.addSystemNotify(notifySend, false);
                Assert.isTrue(libfunCommonReturn.getCode() == LibfunCommonReturn.CODE_OK);
                String testname1 = "testname1";
                NotifyMessage notifyMessage = NotifyMessage.dao.findFirst("select * from libfun_notify_message where receiver_userlogno = ?",
                        testname1);
                Assert.notNull(notifyMessage);


                Long seqid = notifyMessage.getSeqid();
                String[] messsageIds = {seqid.toString()};
                notifyMessageBo.updateMessageDeleteStatus(messsageIds, testname1);
                NotifyMessage message = NotifyMessage.dao.findById(seqid);
                Assert.isTrue(message.getStatus() == MessageStatus.DELETED.getStatus());
                return false;
            }
        });



    }

    /** 根据messageId 更新为可读状态
     * @throws Exception
     */
    @Test
    public void updateMessageReadStatusByMessageId() throws Exception {
        Db.tx(new IAtom() {
                    @Override
                    public boolean run() throws SQLException {
                        boolean sendMessage = notifyMessageBo.sendMessage(MessageTypeEnum.SYSTEM_MESSAGE,
                                "jinyangyang", "test1", "测试更新可读状态", "发送消息", false);
                        Assert.isTrue(sendMessage);
                        NotifyMessage notifyMessage = NotifyMessage.dao.findFirst("select  * from libfun_notify_message where receiver_userlogno = ? and sender_userlogno = ? and type = ?",
                                "jinyangyang", "test1", MessageTypeEnum.SYSTEM_MESSAGE.getType());
                        assertNotNull(notifyMessage);

                        boolean b = notifyMessageBo.updateMessageReadStatusByMessageId(notifyMessage.getSeqid());
                        assertTrue(b);
                        NotifyMessage message = NotifyMessage.dao.findById(notifyMessage.getSeqid());
                        assertTrue(message.getStatus() == MessageStatus.READ.getStatus());

                        return false;
                    }
                });
    }

    /**根据messageid 删除消息
     * @throws Exception
     */
    @Test
    public void deleteMessageByMessageId() throws Exception {
        Db.tx(new IAtom() {
                    @Override
                    public boolean run() throws SQLException {
                        boolean sendMessage = notifyMessageBo.sendMessage(MessageTypeEnum.SYSTEM_MESSAGE,
                                "jinyangyang", "test1", "测试更新可读状态", "发送消息", false);
                        Assert.isTrue(sendMessage);
                        NotifyMessage notifyMessage = NotifyMessage.dao.findFirst("select  * from libfun_notify_message where receiver_userlogno = ? and sender_userlogno = ? and type = ?",
                                "jinyangyang", "test1", MessageTypeEnum.SYSTEM_MESSAGE.getType());
                        assertNotNull(notifyMessage);

                        boolean b = notifyMessageBo.deleteMessageByMessageId(notifyMessage.getSeqid());
                        Assert.isTrue(b);

                        NotifyMessage message = NotifyMessage.dao.findById(notifyMessage.getSeqid());
                        assertTrue(message.getStatus() == MessageStatus.DELETED.getStatus());

                        return false;
                    }
                });

    }

    private NotifySend getNotifySend() {
        NotifySend notifySend = new NotifySend();
        notifySend.setReceiverUserlogno("testname1,testname2");
        String title = "这个是测试标题";
        notifySend.setTitle(title);
        notifySend.setSendContent("这里是测试内容");
        notifySend.setSenderUserlogno("sender");
        notifySend.setIsTop(Boolean.TRUE);
        return notifySend;
    }
}
