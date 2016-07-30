package com.foxdsp.libfun.util;

import com.foxdsp.libfun.model.Menus;
import com.foxdsp.libfun.model.Privilege;
import com.foxdsp.libfun.constant.PrivilegeTypes;
import com.foxdsp.libfun.vo.UserInfo;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by briceli on 15/10/26.
 * 权限控制相关方法都放在此处
 */
public class UserAuthUtil {
    public static UserAuthUtil me = new UserAuthUtil();

    private UserAuthUtil() {

    }

    public static boolean authPathByUser(String path, UserInfo userInfo){
        if(userInfo.getUser().isSuperman()){
            return true;
        }else{
            if(userInfo.getServicePrivilegeMap().get(path) == null){
                return false;
            }else{
                return true;
            }
        }
    }

    /**
     * 用户登录首次初始化权限
     * @param userInfo
     */
    public void initUserInfoPrivilege(UserInfo userInfo){
        //init privilegeMap
        List<Privilege> pList = getUserPrivilegeByType(userInfo.getUserlogno(), PrivilegeTypes.SERVICE_METHOD);
        if (pList != null) {
            for (Privilege p : pList) {
                userInfo.getServicePrivilegeMap().put(p.getStr("value"), p);
            }
        }

        //init menus
        pList = getUserPrivilegeByType(userInfo.getUserlogno(), PrivilegeTypes.MENU);
        if (pList != null) {
            for (Privilege p : pList) {
                userInfo.getMenunoList().add(p.getStr("value"));
            }
        }
        userInfo.setMenus(getAllMenusByUserInfo(userInfo));
    }

    /**
     *
     * @param username
     * @param type
     * @return
     */
    private List<Privilege> getUserPrivilegeByType(String username, int type) {
        return Privilege.dao.find(
                "select p.* from libfun_usersrole ur,libfun_roleprivilege rp,libfun_privilege p where ur.username=? and ur.roleno=rp.roleno and rp.privilegeid=p.seqid and p.type=?", username, type);
    }

    private List<Menus> getAllMenusByUserInfo(UserInfo userinfo) {

        if(userinfo != null &&  userinfo.getUser() != null &&
                userinfo.getUser().isSuperman()){
            return Menus.dao.find("select * from libfun_menus where inuse=1 order by displayorder asc");
        }else if(userinfo!= null) {
            List<Menus> list = null;
            list = Menus.dao.find("select * from libfun_menus where inuse=1 and menuno in ('" + StringUtils.join(userinfo.getMenunoList(), "','") + "') order by displayorder asc");
            if(list == null){
                list = new ArrayList<>();
            }else{
                //补全父菜单
                String menusNoStr = "," + StringUtils.join(userinfo.getMenunoList(),",");
                for(int i = 0; i < list.size(); i++){
                    String pmenuo = list.get(0).getStr("pmenuno");
                    if(menusNoStr.indexOf(","+pmenuo) > -1){
                        //nothing
                    }else{
                        list.add(Menus.dao.findById(pmenuo));
                        menusNoStr = menusNoStr + "," + pmenuo;
                    }
                }
            }
            return list;
        }else{
            return new ArrayList<>();
        }
    }
}
