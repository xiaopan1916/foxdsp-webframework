package com.foxdsp.libfun.bo;


import com.BaseTest;
import com.jfinal.plugin.activerecord.Db;
import com.foxdsp.libfun.model.Privilege;
import com.foxdsp.libfun.model.Role;
import com.foxdsp.libfun.model.Roleprivilege;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.model.Usersrole;
import com.foxdsp.libfun.util.UserAuthUtil;
import com.foxdsp.libfun.vo.UserInfo;
import org.junit.Test;
import static org.junit.Assert.*;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by jinyangyang on 12/28/15 11:20 AM.
 */
public class RoleBoTest extends BaseTest {

    @Resource(name="newRoleBoImpl")
    IRoleBo roleBo;

    @Resource
    IUsersBo usersBo;

    /**
     * 测试插入角色
     */
    @Test
    public void testInsertRole() {
        Role role = new Role();
        role.set("no","aaa");
        role.set("name","测试角色aaa");
        role.set("type","2");
        role.set("remark","remark");

        String msg = roleBo.insert(role);
        assertNull(msg);
        String[] objs = {role.getStr("no"),role.getStr("name"),role.getStr("type"),role.getStr("remark")};
        Role roleDB = Role.dao.findFirst("select *  from libfun_role where no=? and name = ? and type=? and remark=?",objs);
        assertNotNull(roleDB);

        Role role1 = new Role();
        role1.set("no","aaa");
        role1.set("name","测试角色bbb");
        role1.set("type","1");
        role1.set("remark","remark222");
        msg = roleBo.insert(role1);
        assertNotNull(msg);

        role.delete();//清除数据
    }

    /**
     * 测试给角色分配权限
     * 涉及到的bo接口如下:
     *  queryPrivilegeByRoleNo
     *  queryExcludedPrivilegeByRoleNo
     *  insertRolePrivilege
     *  deleteRolePrivilege
     *
     *   AuthService.me.initUserInfoPrivilege 初始化用户servericemap 和 菜单list
     *
     */
    @Test
    public void testRolePrivilege() {
        //准备测试数据
        Role role = new Role();
        role.set("no","单元测试aaa");
        role.set("name","单元测试角色aaa");
        role.set("type","2");
        role.set("remark","remark");
        roleBo.insert(role);//插入角色
        Privilege menuPrivilege = new Privilege();//菜单权限
        menuPrivilege.set("type",1);
        menuPrivilege.set("name","我的订单测试");
        menuPrivilege.set("value","38802413");
        Privilege servicePrivilege = new Privilege();//接口权限
        servicePrivilege.set("type",2);
        servicePrivilege.set("name","foxdsp!!!unittest");
        servicePrivilege.set("value","/jf/orderInfo/genernalInfo");
        menuPrivilege.save();
        servicePrivilege.save();

        //Users u = new Users();
        //u.setUserLogNo("utest1111");

        Users u = new Users();
        u.setUserLogNo("randomutest");
        String superman = "off";
        String inuse = "1";
        String msg = usersBo.insertUser(u,superman,inuse);



        UserInfo u1 = new UserInfo(u);//模拟一个用户

        //测试bo开始
        List<Privilege> privileges = roleBo.queryPrivilegeByRoleNo(role.getStr("no"));
        assertTrue( privileges == null || privileges.size() == 0  );//插入之前已拥有的权限为空

        List<Privilege> notPrivileges = roleBo.queryExcludedPrivilegeByRoleNo(role.getStr("no"));
        assertNotNull(notPrivileges);
        long expectSize = Db.queryLong(" select count(1) from libfun_privilege ");
        assertEquals(notPrivileges.size(),expectSize);//插入之前未拥有的权限是privilege表的总和

        List<Roleprivilege> rolePrivileges  = getRolePrivieges(role, menuPrivilege, servicePrivilege);

        //测试给角色分配权限方法
        roleBo.insertRolePrivilege(rolePrivileges);

        privileges = roleBo.queryPrivilegeByRoleNo(role.getStr("no"));
        assertNotNull(privileges);//插入之后已拥有的权限不为空
        assertEquals(privileges.size(),rolePrivileges.size());

        notPrivileges = roleBo.queryExcludedPrivilegeByRoleNo(role.getStr("no"));
        long totalSize = Db.queryLong(" select count(1) from libfun_privilege ");
        assertEquals(notPrivileges.size(),totalSize-rolePrivileges.size());//插入之后未拥有的权限


        UserAuthUtil.me.initUserInfoPrivilege(u1);
        //assertTrue( !u1.getServicePrivilegeMap().containsKey(servicePrivilege.get("value")) );//用户不拥有接口权限
        assertTrue( !UserAuthUtil.authPathByUser(servicePrivilege.get("value").toString(),u1) );
        assertTrue( !u1.getMenunoList().contains(menuPrivilege.get("value")) );//用户不拥有菜单权限
        //AuthService.me.initUserInfoPrivilege();
        //用户分配这个角色
        Usersrole usersRole = new Usersrole();
        usersRole.set("roleno", role.getStr("no"));
        usersRole.set("username", u.getUserLogNo());
        usersRole.save();

        //用户分配这个角色后
        UserAuthUtil.me.initUserInfoPrivilege(u1);
        logger.info(u1.getServicePrivilegeMap());
        logger.info(u1.getMenunoList());
        //assertTrue( u1.getServicePrivilegeMap().containsKey(servicePrivilege.get("value")) );//用户拥有接口权限
        assertTrue( UserAuthUtil.authPathByUser(servicePrivilege.get("value").toString(),u1) );//用户拥有接口权限
        assertTrue( u1.getMenunoList().contains(menuPrivilege.get("value")) );//用户拥有菜单权限

        usersRole.delete();//用户删除这个角色

        //测试删除bo方法
        roleBo.deleteRolePrivilege(rolePrivileges);
        privileges = roleBo.queryPrivilegeByRoleNo(role.getStr("no"));
        assertTrue( privileges == null || privileges.size() == 0  );//插入之前已拥有的权限为空

        notPrivileges = roleBo.queryExcludedPrivilegeByRoleNo(role.getStr("no"));
        assertNotNull(notPrivileges);
        expectSize = Db.queryLong(" select count(1) from libfun_privilege ");
        assertEquals(notPrivileges.size(),expectSize);//插入之前未拥有的权限

        //清除数据
        //String[] objs = {role.get("no"),role.get("name"),role.get("type"),role.get("remark")};
        //Role roleDB = Role.dao.findFirst("select *  from role where no=? and name = ? and type=? and remark=?",objs);
        //roleDB.delete();
        u.delete();
        role.delete();
        menuPrivilege.delete();
        servicePrivilege.delete();

    }

    private List<Roleprivilege> getRolePrivieges(Role role, Privilege privilege1, Privilege privilege2) {
        //Privilege privilegeDB1 = Privilege.dao.findFirst( "select *  from privilege where name=?",privilege1.getStr("name") );
        //Privilege privilegeDB2 = Privilege.dao.findFirst( "select *  from privilege where name=?",privilege2.getStr("name") );
        //没有必要 在save之后 jFinal已经为seqid赋值了
        String[] strings = { privilege1.get("seqid")+"" , privilege2.get("seqid")+"" };
        List<Roleprivilege> rolePrivileges = new ArrayList<>();
        for (String string : strings) {
            Roleprivilege rolePrivilege = new Roleprivilege();
            rolePrivilege.set("roleno", role.getStr("no"));
            rolePrivilege.set("privilegeid", string);
            rolePrivileges.add(rolePrivilege);
        }
        return rolePrivileges;
    }

}
