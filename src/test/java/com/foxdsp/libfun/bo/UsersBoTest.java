package com.foxdsp.libfun.bo;


import com.BaseTest;
import com.jfinal.plugin.activerecord.Db;
import com.foxdsp.libfun.model.Role;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.model.Usersrole;
import org.junit.Test;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

/**
 * Created by jinyangyang on 12/28/15 11:20 AM.
 */
public class UsersBoTest extends BaseTest {
    @Resource
    IUsersBo usersBo;

    @Resource(name="newRoleBoImpl")
    IRoleBo roleBo;

    /**
     * 测试插入用户
     */
    @Test
    public void testInsertUser() {
        Users user = new Users();
        user.set("UserLogNo","unittestuser");
        String superman = "off";
        String inuse = "1";
        String msg = usersBo.insertUser(user,superman,inuse);
        assertNull(msg);
        String[] objs = { user.getStr("UserLogNo") };
        Users userDB = Users.dao.findFirst("select *  from libfun_users where UserLogNo=?",objs);
        assertNotNull(userDB);


        Users user1 = new Users();
        user1.set("UserLogNo","unittestuser");
        superman = "off";
        inuse = "1";
        msg = usersBo.insertUser(user1,superman,inuse);
        assertNotNull(msg);//删除不成功

        user.delete();//清除数据
    }

    /**
     * 测试给用户分配角色
     * 涉及到的bo接口如下:
     *  queryRoleByUserName
     *  queryExcludedRoleByUsername
     *  insertUserRole
     *  deleteUserRoleByUsername
     */
    @Test
    public void testUsersRole() {
        Users user = new Users();
        user.set("UserLogNo","unittestuser");
        String superman = "off";
        String inuse = "1";
        String msg = usersBo.insertUser(user,superman,inuse);
        assertNull(msg);//插入用户


        String userLogNo = user.getStr("UserLogNo");

        //测试bo开始
        List<Role> roles = usersBo.queryRoleByUserName(userLogNo);
        assertTrue( roles == null || roles.size() == 0  );//插入之前已拥有的角色为空

        List<Role> notRoles = usersBo.queryExcludedRoleByUsername(userLogNo);
        assertNotNull(notRoles);
        long expectSize = Db.queryLong(" select count(1) from libfun_role ");
        assertEquals(notRoles.size(),expectSize);//插入之前未拥有的角色数目是role表的总和

        Role role = new Role();
        role.set("no","单元测试aaa");
        role.set("name","单元测试角色aaa");
        role.set("type","2");
        role.set("remark","remark");
        roleBo.insert(role);//插入角色

        //准备测试数据
        List<Usersrole> usersRoles = getUsersRoles(user,role);
        //测试给用户分配角色
        usersBo.insertUserRole(usersRoles);

        roles = usersBo.queryRoleByUserName(userLogNo);
        assertNotNull(roles);//插入之后已拥有的角色不为空
        assertEquals(roles.size(),usersRoles.size());

        notRoles = usersBo.queryExcludedRoleByUsername(userLogNo);
        long totalSize = Db.queryLong(" select count(1) from libfun_role ");
        assertEquals(notRoles.size(),totalSize-usersRoles.size());//插入之后未拥有的角色

        //测试删除bo方法
        usersBo.deleteUserRoleByUsername(usersRoles);
        roles = usersBo.queryRoleByUserName(userLogNo);
        assertTrue( roles == null || roles.size() == 0  );//已拥有的角色为空

        notRoles = usersBo.queryExcludedRoleByUsername(userLogNo);
        assertNotNull(notRoles);
        expectSize = Db.queryLong(" select count(1) from libfun_role ");
        assertEquals(notRoles.size(),expectSize);//未拥有的角色


        user.delete();
        role.delete();
    }


    private List<Usersrole> getUsersRoles(Users user,Role role) {
        List<Usersrole> usersRoles = new ArrayList<>();
        Usersrole usersRole = new Usersrole();
        usersRole.set("roleno", role.get("no"));
        usersRole.set("username", user.get("UserLogNo"));
        usersRoles.add(usersRole);
        return usersRoles;
    }


}
