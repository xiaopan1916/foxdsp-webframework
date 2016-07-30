package com.foxdsp.libfun.controller;

import com.jfinal.plugin.activerecord.Db;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.model.Privilege;
import org.apache.commons.lang3.StringUtils;

/** 权限管理
 * Created by panfenquan on 2015/9/27.
 */
public class PrivilegeController extends CrudController<Privilege>{

    @Override
    public void index() {
        renderFreeMarker("/freemarkerTemplate/libfun/privilege.ftl");
    }

    @Override
    public void delete() {
        super.delete();
    }

    @Override
    public void update() {
        Privilege privilege = getModel(Privilege.class, "editObj");
        String seqid = privilege.get("seqid");
        if (StringUtils.isBlank(seqid)) {
            renderJson(LibfunCommonReturn.genErrorReturn("请选中列表的一行！"));
            return;
        }
        Privilege dbPrivilege = Privilege.dao.findById(seqid);
        if (dbPrivilege == null) {
            renderJson(LibfunCommonReturn.genErrorReturn("权限不存在！"));
            return;
        }
        String value = dbPrivilege.getStr("value");
        if (!StringUtils.equals(value, privilege.getStr("value"))) {
            Privilege aPrivilege = Privilege.dao.findFirst("select * from libfun_privilege where value = ? ", privilege.getStr("value"));
            if (aPrivilege != null) {
                renderJson(LibfunCommonReturn.genErrorReturn("权限已经存在"));
                return;
            }
        }
        privilege.update();
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    @Override
    public void insert() {
        Privilege privilege = getModel(Privilege.class, "editObj");
        String seqid = privilege.get("seqid");
        if (StringUtils.isNotBlank(seqid)) {
            renderJson(LibfunCommonReturn.genErrorReturn("不要选中列表的行！"));
            return;
        }
        Long count = Db.findFirst("select count(*) as count from libfun_privilege where value = ?", privilege.get("value")).getLong("count");
        if (count > 0) {
            renderJson(LibfunCommonReturn.genErrorReturn("值已经存在！"));
        }
        privilege.save();
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    @Override
    public void query() {
        super.query();
    }
}
