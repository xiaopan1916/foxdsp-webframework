package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.model.BaseModel;
import com.foxdsp.libfun.model.Menus;
import com.foxdsp.libfun.vo.UserInfo;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by jinyangyang on 12/28/15 6:06 PM.
 */
@Component("newMenusBoImpl")
public class MenusBoImpl implements IMenusBo {

    @Override
    public String insert(Menus menus) {
        String pmenuno = menus.getStr("pmenuno");
        String seqid = menus.getStr("seqid");
        if (StringUtils.isNotBlank(seqid)) {
            return " 请刷新页面!";

        }
        if (StringUtils.isBlank(pmenuno)) {
            return "没有选择任何父节点,无法添加菜单,先选择下面的顺序调整";
        }
        Menus menu = Menus.dao.findFirst("select * from libfun_menus order by seqid desc limit 1");
        String menuno = menu.getStr("menuno");
        menus.set("menuno", Integer.valueOf(menuno) +1);
        menus.save();
        return null;
    }


    @Override
    public String delete(Menus menus) {
        String menuno = menus.getStr("menuno");
        if (StringUtils.isBlank(menuno)) {
            return "菜单编号为空！";
        }
        if (StringUtils.equals(menuno, "0")) {
            return "菜单根目录不允许删除！";
        }
        List<Menus> menusList = Menus.dao.find("select * from libfun_menus where PMenuNo = ?", menuno);

        if (CollectionUtils.isNotEmpty(menusList)) {
            return "该菜单还有子菜单，请先删除子菜单！";
        }
        menus.delete();
        return null;
    }

    @Override
    public List<Menus> getAllMenusByUserInfo(UserInfo userinfo) {
        if(userinfo != null &&  userinfo.getUser() != null &&
                userinfo.getUser().isSuperman()){
            return getInuseMenus();
        }else {
            return getMenusByMenunos(userinfo.getMenunoList());
        }
    }


    //dao的逻辑移到这里
    public List<Menus> getAllMenus() {
        return Menus.dao.find("select * from libfun_menus order by displayorder asc");
    }

    public List<Menus> getInuseMenus() {
        return Menus.dao.find("select * from libfun_menus where inuse=1 order by displayorder asc");
    }

    public List<Menus> getMenusByMenunos(List<String> menunos) {
        return Menus.dao.find("select * from libfun_menus where inuse=1 and menuno in (" + BaseModel.getSQLForIn(menunos.size())+")",menunos.toArray(new Object[menunos.size()]));
    }

    public List<Menus> selectChildMenus(String parentId) {
        return Menus.dao.find("select * from libfun_menus where PMenuNo = ? order by displayorder asc",parentId);
    }
}
