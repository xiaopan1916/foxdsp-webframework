package com.foxdsp.libfun.controller;

import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.foxdsp.libfun.bo.IMenusBo;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.model.Menus;
import org.apache.commons.lang3.StringUtils;

import java.util.List;
import java.util.Map;

/**菜单管理
 * Created by panfenquan
 * 2015/9/30
 */
public class MenuController extends CrudController<Menus> {

    private static IMenusBo menusBo = ctx.getBean(IMenusBo.class);

    @Override
    public void index() {
        List<Menus> menuses = Menus.dao.find("select * from libfun_menus where inuse = 1 order by displayorder asc");
        setAttr("menuName", JsonKit.toJson(menuses));
        renderFreeMarker("/freemarkerTemplate/libfun/menus.ftl");
    }

    @Override
    public void delete() {
//        String menuno = getPara("menuno");
//        if (StringUtils.isBlank(menuno)) {
//            renderJson(LibfunCommonReturn.genErrorReturn("菜单编号为空！"));
//            return;
//        }
//        if (StringUtils.equals(menuno, "0")) {
//            renderJson(LibfunCommonReturn.genErrorReturn("菜单根目录不允许删除！"));
//            return;
//        }
//        List<Menus> menusList = Menus.dao.find("select * from libfun_menus where PMenuNo = ?", menuno);
//
//        if (CollectionUtils.isNotEmpty(menusList)) {
//            renderJson(LibfunCommonReturn.genErrorReturn("该菜单还有子菜单，请先删除子菜单！"));
//            return;
//        }
        Menus menus = new Menus();
        Map<String, String[]> paraMap = getParaMap();
        for (String key : paraMap.keySet()) {
            menus.put(key, paraMap.get(key)[0]);
        }
        String str = menusBo.delete(menus);
        if ( str != null ) {
            renderJson(LibfunCommonReturn.genErrorReturn(str));
        } else {
            renderJson(LibfunCommonReturn.genOkReturn());
        }
    }

    @Override
    public void update() {
        Menus menus = getModel(Menus.class, "editObj");
        menus.update();
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    @Override
    public void insert() {
          Menus menus = getModel(Menus.class, "editObj");
//        String pmenuno = menus.getStr("pmenuno");
//        String seqid = menus.getStr("seqid");
//        if (StringUtils.isNotBlank(seqid)) {
//            renderJson(LibfunCommonReturn.genErrorReturn(" 请刷新页面！"));
//            return;
//        }
//
//        if (StringUtils.isBlank(pmenuno)) {
//            renderJson(LibfunCommonReturn.genErrorReturn("没有选择任何父节点,无法添加菜单,先选择下面的顺序调整！"));
//            return;
//        }
//        Menus menu = Menus.dao.findFirst("select * from libfun_menus order by seqid desc limit 1");
//        String menuno = menu.getStr("menuno");
//        menus.set("menuno", Integer.valueOf(menuno) +1);
//        menus.save();

        String str = menusBo.insert(menus);
        if ( str != null ) {
            renderJson(LibfunCommonReturn.genErrorReturn(str));
        } else {
            renderJson(LibfunCommonReturn.genOkReturn());
        }

    }

    @Override
    public void query() {
        super.query();
    }

    public void updateMenusTree() {
        String displayOrder = getPara("displayOrder");
        String pmenuNo = getPara("pmenuNo");
        String seqid = getPara("seqid");
        if (StringUtils.isBlank(pmenuNo)) {
            renderJson(LibfunCommonReturn.genErrorReturn("菜单编号不存在"));
            return;
        }

        Db.update("update libfun_menus set pmenuno = ?,displayorder =? where seqid = ?",pmenuNo,displayOrder,seqid);
        renderJson(LibfunCommonReturn.genOkReturn());

    }

}


