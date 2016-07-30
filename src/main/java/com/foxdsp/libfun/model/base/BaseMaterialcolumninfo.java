package com.foxdsp.libfun.model.base;

import com.jfinal.plugin.activerecord.IBean;
import com.jfinal.plugin.activerecord.Model;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseMaterialcolumninfo<M extends BaseMaterialcolumninfo<M>> extends Model<M> implements IBean {

	public void setSeqid(Integer Seqid) {
		set("Seqid", Seqid);
	}

	public Integer getSeqid() {
		return get("Seqid");
	}

	public void setName(String name) {
		set("name", name);
	}

	public String getName() {
		return get("name");
	}

	public void setKeyvalue(String keyvalue) {
		set("keyvalue", keyvalue);
	}

	public String getKeyvalue() {
		return get("keyvalue");
	}

	public void setType(String type) {
		set("type", type);
	}

	public String getType() {
		return get("type");
	}

	public void setHtmlType(String htmlType) {
		set("htmlType", htmlType);
	}

	public String getHtmlType() {
		return get("htmlType");
	}

	public void setMaterialtypename(String materialtypename) {
		set("materialtypename", materialtypename);
	}

	public String getMaterialtypename() {
		return get("materialtypename");
	}

	public void setJoinColumn(String joinColumn) {
		set("joinColumn", joinColumn);
	}

	public String getJoinColumn() {
		return get("joinColumn");
	}

	public void setRemark(String remark) {
		set("remark", remark);
	}

	public String getRemark() {
		return get("remark");
	}

	public void setSequence(Integer sequence) {
		set("sequence", sequence);
	}

	public Integer getSequence() {
		return get("sequence");
	}

}