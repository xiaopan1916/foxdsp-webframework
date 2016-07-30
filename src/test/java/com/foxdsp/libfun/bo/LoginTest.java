package com.foxdsp.libfun.bo;

import com.BaseTest;
import com.foxdsp.libfun.model.Users;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.IAtom;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.sql.SQLException;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

/**
 * 登陆测试
 * Created by panpan
 * on 16/1/14.
 */
public class LoginTest extends BaseTest {

    @Autowired
    IUsersBo usersBo;

    HttpServletRequest request = new MockHttpServletRequest();

    @Test
    public void testLogin() {
        Db.tx(new IAtom() {
            @Override
            public boolean run() throws SQLException {


                String ip = request.getRemoteAddr();

                // 非管理员,失效用户
                Users userDB = getUsers(false, false, "user1");
                LibfunCommonReturn commonReturn = usersBo.login(userDB.getUserLogNo(), userDB.getUserPassword(), ip);
                assertEquals(commonReturn.getMessage(), "用户失效");

                //非管理员,正常用户
                Users users = getUsers(false, true, "user2");
                LibfunCommonReturn aReturn = usersBo.login(users.getUserLogNo(), users.getUserPassword(), ip);
                assertEquals(aReturn.getMessage(), "成功");


                // 管理员,正常
                Users users1 = getUsers(true, true, "user3");
                LibfunCommonReturn libfunCommonReturn = usersBo.login(users1.getUserLogNo(), users1.getUserPassword(), ip);
                assertEquals(libfunCommonReturn.getMessage(), "成功");


                //管理员,失效
                Users users2 = getUsers(true, false, "user4");
                LibfunCommonReturn login = usersBo.login(users2.getUserLogNo(), users2.getUserPassword(), ip);
                assertEquals(login.getMessage(), "用户失效");

                //用户名错误
                Users user5 = getUsers(false, true, "user5");
                LibfunCommonReturn libfunCommonReturn1 = usersBo.login("useror", user5.getUserPassword(), ip);

                assertEquals(libfunCommonReturn1.getMessage(), "用户名错误");
                // 密码错误
                LibfunCommonReturn errorReturn = usersBo.login(user5.getUserLogNo(), "2222", ip);
                assertEquals(errorReturn.getMessage(), "密码错误");

                return false;
            }
        });
    }

    private Users getUsers(Boolean isSuperMan, Boolean inuse, String username) {
        Users user = new Users();
        user.setUserLogNo(username);
        user.setUserPassword("1111");
        String superman = isSuperMan ? "on" : "off";
        String use = inuse ? "on" : "off";
        String msg = usersBo.insertUser(user, superman, use);
        assertNull(msg);
        String[] objs = {user.getStr("UserLogNo")};
        Users userDB = Users.dao.findFirst("select *  from libfun_users where UserLogNo=?", objs);
        assertNotNull(userDB);
        return userDB;
    }

    @Test
    public void testuser() {

    }
}
