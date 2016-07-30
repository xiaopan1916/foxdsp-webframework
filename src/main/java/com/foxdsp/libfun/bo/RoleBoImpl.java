package com.foxdsp.libfun.bo;

import com.jfinal.plugin.activerecord.Db;
import com.foxdsp.libfun.model.Privilege;
import com.foxdsp.libfun.model.Role;
import com.foxdsp.libfun.model.Roleprivilege;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by jinyangyang on 12/28/15 10:38 AM.
 */
@Component("newRoleBoImpl")
public class RoleBoImpl implements  IRoleBo {

    public String insert(Role role) {

        String seqid = role.get("seqid");
        if (StringUtils.isNotBlank(seqid)) {
            return "不要选中列表的行！";
        }
        Long count = Db.findFirst("select count(*) as count from libfun_role where no = ?", role.get("no")).getLong("count");
        if (count > 0) {
            return "角色编号已经存在！";
        }
        role.save();
        return null;

    }

    public String update(Role role) {
        String seqid = role.get("seqid");
        if (StringUtils.isBlank(seqid)) {
            return "请选中列表的一行！";
        }
        Role dbRole = Role.dao.findById(seqid);
        if (dbRole == null) {
            return "角色不存在！";
        }
        String value = dbRole.getStr("no");
        if (!StringUtils.equals(value, role.getStr("no"))) {
            Role aRole = Role.dao.findFirst("select * from libfun_role where no = ? ", role.getStr("no"));
            if (aRole != null) {
                return "角色已经存在";
            }
        }
        role.update();
        return null;
    }


    @Override
    public List<Privilege> queryPrivilegeByRoleNo(String roleNo) {
        return Privilege.dao.
                find("select p.* from libfun_privilege p,libfun_roleprivilege rp where rp.roleno= ? and rp.privilegeid=p.seqid ", roleNo);
    }

    @Override
    public List<Privilege> queryExcludedPrivilegeByRoleNo(String roleNo) {
        return  Privilege.dao.
                find("select * from libfun_privilege where seqid not in(select privilegeid from libfun_roleprivilege where roleno=?)",roleNo);
    }

    @Override
    public void insertRolePrivilege(List<Roleprivilege> rolePrivileges) {
        int[] batch = Db.batch("insert into libfun_roleprivilege(roleno,privilegeid) value(?,?) ",
                "roleno,privilegeid", rolePrivileges, rolePrivileges.size());

    }

    @Override
    public void deleteRolePrivilege(List<Roleprivilege> rolePrivileges) {
        int[] batch = Db.batch("delete  from libfun_roleprivilege  where roleno=? and privilegeid = ?",
                "roleno,privilegeid", rolePrivileges, rolePrivileges.size());
    }
}
