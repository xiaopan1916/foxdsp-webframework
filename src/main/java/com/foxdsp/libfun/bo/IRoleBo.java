package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.model.Privilege;
import com.foxdsp.libfun.model.Role;
import com.foxdsp.libfun.model.Roleprivilege;

import java.util.List;

/**
 * Created by jinyangyang on 12/28/15 10:29 AM.
 */
public interface IRoleBo {

     String insert(Role role);

     String update(Role role);


    /**
     * 查询角色已经拥有的权限
     * @param roleNo
     * @return
     */
    List<Privilege> queryPrivilegeByRoleNo(String roleNo);

    /**
     * 查询角色已经没有的权限
     * @param roleNo
     * @return
     */
    List<Privilege> queryExcludedPrivilegeByRoleNo(String roleNo);

    void insertRolePrivilege(List<Roleprivilege> rolePrivileges);

    void deleteRolePrivilege(List<Roleprivilege> rolePrivileges);
}
