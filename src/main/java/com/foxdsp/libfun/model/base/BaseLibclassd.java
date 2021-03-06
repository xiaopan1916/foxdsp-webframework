package com.foxdsp.libfun.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseLibclassd<M extends BaseLibclassd<M>> extends Model<M> implements IBean {

	public void setSeqId(Long SeqId) {
		set("SeqId", SeqId);
	}

	public Long getSeqId() {
		return get("SeqId");
	}

	public void setClassNo(String ClassNo) {
		set("ClassNo", ClassNo);
	}

	public String getClassNo() {
		return get("ClassNo");
	}

	public void setItemNo(String ItemNo) {
		set("ItemNo", ItemNo);
	}

	public String getItemNo() {
		return get("ItemNo");
	}

	public void setClassItemId(String ClassItemId) {
		set("ClassItemId", ClassItemId);
	}

	public String getClassItemId() {
		return get("ClassItemId");
	}

	public void setItemName(String ItemName) {
		set("ItemName", ItemName);
	}

	public String getItemName() {
		return get("ItemName");
	}

	public void setItemOrder(Integer ItemOrder) {
		set("ItemOrder", ItemOrder);
	}

	public Integer getItemOrder() {
		return get("ItemOrder");
	}

	public void setItemValue(String ItemValue) {
		set("ItemValue", ItemValue);
	}

	public String getItemValue() {
		return get("ItemValue");
	}

	public void setRemark(String Remark) {
		set("Remark", Remark);
	}

	public String getRemark() {
		return get("Remark");
	}

	public void setEditBy(String EditBy) {
		set("EditBy", EditBy);
	}

	public String getEditBy() {
		return get("EditBy");
	}

	public void setEditTime(String EditTime) {
		set("EditTime", EditTime);
	}

	public String getEditTime() {
		return get("EditTime");
	}

}
