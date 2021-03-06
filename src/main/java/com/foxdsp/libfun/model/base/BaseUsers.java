package com.foxdsp.libfun.model.base;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.IBean;

/**
 * Generated by JFinal, do not modify this file.
 */
@SuppressWarnings("serial")
public abstract class BaseUsers<M extends BaseUsers<M>> extends Model<M> implements IBean {

	public void setSeqId(Long SeqId) {
		set("SeqId", SeqId);
	}

	public Long getSeqId() {
		return get("SeqId");
	}

	public void setUserLogNo(String UserLogNo) {
		set("UserLogNo", UserLogNo);
	}

	public String getUserLogNo() {
		return get("UserLogNo");
	}

	public void setUserPassword(String UserPassword) {
		set("UserPassword", UserPassword);
	}

	public String getUserPassword() {
		return get("UserPassword");
	}

	public void setSuperMan(Integer SuperMan) {
		set("SuperMan", SuperMan);
	}

	public Integer getSuperMan() {
		return get("SuperMan");
	}

	public void setTrueName(String TrueName) {
		set("TrueName", TrueName);
	}

	public String getTrueName() {
		return get("TrueName");
	}

	public void setBindIp(String BindIp) {
		set("BindIp", BindIp);
	}

	public String getBindIp() {
		return get("BindIp");
	}

	public void setInUse(Integer InUse) {
		set("InUse", InUse);
	}

	public Integer getInUse() {
		return get("InUse");
	}

	public void setTel(String Tel) {
		set("Tel", Tel);
	}

	public String getTel() {
		return get("Tel");
	}

	public void setEmail(String Email) {
		set("Email", Email);
	}

	public String getEmail() {
		return get("Email");
	}

	public void setCopartnerNo(String CopartnerNo) {
		set("CopartnerNo", CopartnerNo);
	}

	public String getCopartnerNo() {
		return get("CopartnerNo");
	}

}
