package com.foxdsp.libfun.controller;

import com.foxdsp.common.util.lang.DateStringUtil;
import com.jfinal.aop.Before;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.tx.Tx;
import com.foxdsp.libfun.bo.NotifyMessageBo;
import com.foxdsp.libfun.bo.NotifySendBo;
import com.foxdsp.libfun.constant.MessageTypeEnum;
import com.foxdsp.libfun.constant.UserValidEnum;
import com.foxdsp.libfun.model.NotifyMessage;
import com.foxdsp.libfun.model.NotifySend;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.validator.MessageValidator;
import com.foxdsp.libfun.vo.*;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by panpan
 * on 16/6/21.
 */
public class MessageController extends CrudController<NotifySend> {

    private static NotifySendBo notifySendBo = ctx.getBean(NotifySendBo.class);

    private static NotifyMessageBo notifyMessageBo = ctx.getBean(NotifyMessageBo.class);

    @Override
    public void index() {
        setAttr("startTime", DateStringUtil.today2());
        setAttr("pageTitle", "消息列表");
        setAttr("endTime", DateStringUtil.DEFAULT_DAY.addDays(7));
        setAttr("pageUrl", "/jf/messageList");
        renderFreeMarker("/freemarkerTemplate/libfun/messageList.ftl");
    }

    public void addSendMessage() {
        List<Users> userses = Users.dao.find("select * from libfun_users where inuse = ?", UserValidEnum.INUSE.getStatus());
        List<String> userNames = new ArrayList<>();
        for (Users userse : userses) {
            String userLogNo = userse.getUserLogNo();
            userNames.add(userLogNo);
        }

        setAttr("allUserLogNo", StringUtils.join(userNames,","));
        setAttr("userses", userses);
        renderFreeMarker("/freemarkerTemplate/libfun/addSendMessage.ftl");
    }

    @Before({MessageValidator.class,Tx.class})
    @Override
    public void insert() {
        NotifySend notifySend = getModel(NotifySend.class, "editObj");
        notifySend.setSenderUserlogno(getUserNameLogo());
        Boolean isSendTime = getParaToBoolean("sendSentinel");
        LibfunCommonReturn libfunCommonReturn = notifySendBo.addSystemNotify(notifySend, isSendTime);
        renderJson(libfunCommonReturn);
    }

    public void updateSendMessage() {
        String seqid = getPara("seqid");

        NotifySend notifySend = NotifySend.dao.findById(seqid);
        setAttr("notifySend", notifySend);
        String receiverUserlogno = notifySend.getReceiverUserlogno();
        String[] userLogNos = receiverUserlogno.split(",");
        setAttr("userLogNos", userLogNos);

        List<Users> userses = Users.dao.find("select * from libfun_users where inuse = ?", UserValidEnum.INUSE.getStatus());

        setAttr("userses", userses);
        renderFreeMarker("/freemarkerTemplate/libfun/updateSendMessage.ftl");
    }

    @Before({MessageValidator.class,Tx.class})
    @Override
    public void update() {
        NotifySend notifySend = getModel(NotifySend.class, "editObj");
        notifySend.setSenderUserlogno(getUserNameLogo());
        Boolean isSendTime = getParaToBoolean("sendSentinel");
        LibfunCommonReturn libfunCommonReturn = notifySendBo.updateNotifySend(notifySend,isSendTime);
        renderJson(libfunCommonReturn);
    }

    /**
     *更新置顶状态
     */
    public void updateTopStatus() {
        Long seqid = getParaToLong("seqid");
        boolean top = getParaToBoolean("top");
        LibfunCommonReturn libfunCommonReturn = notifySendBo.updateTopStatus(seqid,top);
        renderJson(libfunCommonReturn);
    }

    /**
     * 分页查询消息
     */
    public void queryMessages() {
        String pageNumber = getPara("pageNumber");
        Integer type = getParaToInt("type");
        MessageTypeEnum messageTypeEnum = MessageTypeEnum.getMessageTypeEnum(type);
        MessageInfoAndCount messageInfoAndCount = new MessageInfoAndCount();
        Page<NotifyMessage> paging = notifyMessageBo.queryMessageByPage(messageTypeEnum, pageNumber, getUserNameLogo());
        MessageCount messageCount = notifyMessageBo.countNotReadMessages(getUserNameLogo());
        messageInfoAndCount.setMessageCount(messageCount);
        messageInfoAndCount.setPaging(paging);
        renderJson(messageInfoAndCount);

    }

    /**
     * 更新消息的状态为已读的状态
     */
    public void updateMessageReadStatus() {
        Integer type = getParaToInt("type");
        MessageTypeEnum messageTypeEnum = MessageTypeEnum.getMessageTypeEnum(type);
        notifyMessageBo.updateMessageReadStatus(messageTypeEnum, getUserNameLogo());
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    /**
     * 更新消息状态为删除的状态
     */
    public void updateMessageDeleteStatus() {
        String messageIds = getPara("messageIds");
        String[] strings = messageIds.split(",");
        notifyMessageBo.updateMessageDeleteStatus(strings, getUserNameLogo());
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    @Override
    public void query() {
        DataTableQueryInfo queryInfo = new DataTableQueryInfo(getParaMap());
        String sql = " from libfun_notify_send where 1=1";
        Date startDate = getParaToDate("startDate");
        Date endDate = getParaToDate("endDate");
        String titleContent = getPara("titleContent");
        if (StringUtils.isNotBlank(titleContent)) {
            sql += " and ( title like  '%" + titleContent + "%' or send_content like '%" + titleContent + "%' )";
        }
        if (startDate != null && endDate != null) {
            sql += " and created_time > '" + DateStringUtil.formatDay(startDate) +
                    "' and created_time < '" + DateStringUtil.formatDay(endDate)+"'";
        }
        Page<NotifySend> page = NotifySend.dao.paginate(queryInfo.getPageNumber()
                , queryInfo.getPageSize()
                ,"select * " , sql +queryInfo.getOrderStr());
        renderJson(JsonKit.toJson(new DataTableQueryReturn(page, queryInfo.getSeq())));
    }
}
