package com.foxdsp.libfun.controller;


import com.jfinal.aop.Before;
import com.foxdsp.libfun.bo.IRoleBo;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.model.Privilege;
import com.foxdsp.libfun.model.Role;
import com.foxdsp.libfun.model.Roleprivilege;
import com.foxdsp.libfun.validator.RoleValidator;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * 角色管理
 * Created by panfenquan
 * 2015/9/28
 */
public class RoleController extends CrudController<Role> {

    private static IRoleBo roleBo = ctx.getBean(IRoleBo.class);

    @Override
    public void index() {
        renderFreeMarker("/freemarkerTemplate/libfun/role.ftl");
    }

    @Override
    public void delete() {
        super.delete();
    }

    @Override
    public void update() {
        Role role = getModel(Role.class, "editObj");
        String msg = roleBo.update(role);
        if ( msg != null ) {
            renderJson(LibfunCommonReturn.genErrorReturn(msg));
        } else {
            renderJson(LibfunCommonReturn.genOkReturn());
        }
    }

    @Override
    @Before(RoleValidator.class)
    public void insert() {
        Role role = getModel(Role.class, "editObj");
        String msg = roleBo.insert(role);
        if ( msg != null ) {
            renderJson(LibfunCommonReturn.genErrorReturn(msg));
        } else {
            renderJson(LibfunCommonReturn.genOkReturn());
        }
    }

    @Override
    public void query() {
        super.query();
    }

    /**
     * 已经拥有的权限列表
     */
    public void queryPrivilegeByRoleNo() {
        String roleNo = getPara("roleNo");
        if (StringUtils.isBlank(roleNo)) {
            renderJson(LibfunCommonReturn.genErrorReturn("角色编号为空"));
            return;
        }
        //List<Privilege> privileges = Privilege.dao.
                //find("select p.* from privilege p,roleprivilege rp where rp.roleno= ? and rp.privilegeid=p.seqid ", roleNo);
        List<Privilege> privileges =  roleBo.queryPrivilegeByRoleNo(roleNo);
        renderJson("data", privileges);

    }

    /**
     * 未选择的权限列表
     */
    public void queryExcludedPrivilegeByRoleNo() {
        String roleNo = getPara("roleNo");
        if (StringUtils.isBlank(roleNo)) {
            renderJson(LibfunCommonReturn.genErrorReturn("角色编号为空"));
            return;
        }
        //List<Privilege> privileges = Privilege.dao.
                //find("select * from privilege where seqid not in(select privilegeid from roleprivilege where roleno='" + roleNo + "')");
        List<Privilege> privileges = roleBo.queryExcludedPrivilegeByRoleNo(roleNo);
        renderJson("data", privileges);
    }

    /**
     * 赋予角色权限
     */
    public void insertRolePrivilege() {
        List<Roleprivilege> rolePrivileges = getRolePrivileges();
        if (CollectionUtils.isEmpty(rolePrivileges)) return;

        //int[] batch = Db.batch("insert into roleprivilege(roleno,privilegeid) value(?,?) ",
                //"roleno,privilegeid", rolePrivileges, rolePrivileges.size());
        roleBo.insertRolePrivilege(rolePrivileges);
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    private List<Roleprivilege> getRolePrivileges() {
        String roleNo = getPara("roleNo");
        if (StringUtils.isBlank(roleNo)) {
            renderJson(LibfunCommonReturn.genErrorReturn("角色编号为空"));
            return new ArrayList<>();
        }
        String privilegeIds = getPara("privilegeIds");
        if (StringUtils.isBlank(privilegeIds)) {
            return new ArrayList<>();
        }
        String[] strings = privilegeIds.split(",");
        List<Roleprivilege> rolePrivileges = new ArrayList<>();

        for (String string : strings) {
            Roleprivilege rolePrivilege = new Roleprivilege();
            rolePrivilege.set("roleno", roleNo);
            rolePrivilege.set("privilegeid", string);
            rolePrivileges.add(rolePrivilege);
        }
        return rolePrivileges;
    }

    /**
     * 删除角色权限
     */
    public void deleteRolePrivilege() {
        List<Roleprivilege> rolePrivileges = getRolePrivileges();
        //int[] batch = Db.batch("delete  from roleprivilege  where roleno=? and privilegeid = ?",
                //"roleno,privilegeid", rolePrivileges, rolePrivileges.size());
        roleBo.deleteRolePrivilege(rolePrivileges);
        renderJson(LibfunCommonReturn.genOkReturn());
    }
}


