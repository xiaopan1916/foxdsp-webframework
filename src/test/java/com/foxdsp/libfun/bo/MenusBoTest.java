package com.foxdsp.libfun.bo;

import com.BaseTest;
import com.foxdsp.libfun.model.Menus;
import org.junit.Test;

import static org.junit.Assert.*;
import javax.annotation.Resource;

/**
 * Created by jinyangyang on 12/28/15 7:03 PM.
 */
public class MenusBoTest extends BaseTest {

    @Resource(name="newMenusBoImpl")
    IMenusBo menusBo;

    @Test
    public void testInsertMenu(){

        Menus menus = new Menus();
        menus.set("menuname","unittest menu");
        //menus.set("PMenuNo",123);//不指定父级菜单
        menus.set("MenuUrl","###");
        String code = menusBo.insert(menus);
        assertNotNull(code);

        menus.set("PMenuNo","0");//指定父级菜单
        code = menusBo.insert(menus);
        assertNull(code);//插入成功

        menus.delete();

    }

    @Test
    public  void testDelete() {
        Menus menus = new Menus();
        menus.set("menuno","0");
        String code = menusBo.delete(menus);
        logger.info(code);
        assertNotNull(code);

        menus = new Menus();
        menus.set("menuname","unittest menu");
        menus.set("pmenuno","0");
        menus.set("MenuUrl","###");
        code = menusBo.insert(menus);
        logger.info(code);

        //添加一个子菜单
        Menus menus1 = new Menus();
        menus1.set("menuname","unittest menu sub");
        menus1.set("pmenuno",menus.getInt("menuno")+"");
        menus1.set("MenuUrl","#####");
        menusBo.insert(menus1);

        menus.set("menuno",menus.getInt("menuno")+"");
        code = menusBo.delete(menus);
        logger.info(code);
        assertNotNull(code);//有子菜单不可以直接删除

        menus1.set("menuno",menus1.getInt("menuno")+"");
        code = menusBo.delete(menus1);//删除子菜单
        logger.info(code);
        assertNull(code);

        code = menusBo.delete(menus);//删除子菜单后可以删除
        logger.info(code);
        assertNull(code);
    }

}
