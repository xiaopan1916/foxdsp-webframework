package com.foxdsp.libfun.model.base;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseNotifyMessage<M extends BaseNotifyMessage<M>> extends Model<M> implements IBean {

	public void setSeqid(Long seqid) {
		set("seqid", seqid);
	}

	public Long getSeqid() {
		return get("seqid");
	}

	public void setReceiverUserlogno(String receiverUserlogno) {
		set("receiver_userlogno", receiverUserlogno);
	}

	public String getReceiverUserlogno() {
		return get("receiver_userlogno");
	}

	public void setSenderUserlogno(String senderUserlogno) {
		set("sender_userlogno", senderUserlogno);
	}

	public String getSenderUserlogno() {
		return get("sender_userlogno");
	}

	public void setTitle(String title) {
		set("title", title);
	}

	public String getTitle() {
		return get("title");
	}

	public void setMessageContent(String messageContent) {
		set("message_content", messageContent);
	}

	public String getMessageContent() {
		return get("message_content");
	}

	public void setIsTop(Boolean isTop) {
		set("is_top", isTop);
	}

	public Boolean getIsTop() {
		return get("is_top");
	}

	public void setType(Integer type) {
		set("type", type);
	}

	public Integer getType() {
		return get("type");
	}

	public void setStatus(Integer status) {
		set("status", status);
	}

	public Integer getStatus() {
		return get("status");
	}

	public void setCreatedTime(java.util.Date createdTime) {
		set("created_time", createdTime);
	}

	public java.util.Date getCreatedTime() {
		return get("created_time");
	}

}
