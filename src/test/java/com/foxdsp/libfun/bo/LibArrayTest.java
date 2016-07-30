package com.foxdsp.libfun.bo;


import com.BaseTest;

import com.foxdsp.libfun.model.Libclassd;
import com.foxdsp.libfun.model.Libclassm;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

import static org.junit.Assert.*;

/**
 * 数组维护测试
 * Created by panpan
 * on 15/12/28.
 */
public class LibArrayTest extends BaseTest {

    @Autowired
    private LibArrayBo libArrayBo;

    @Test
    public void insertLibArrayTest() {

        Libclassm libClassM = new Libclassm();
        libClassM.set("ClassNo", "hello");
        libClassM.set("ClassName", "我是一个测试数组");

        LibfunCommonReturn libfunCommonReturn = libArrayBo.insertLibArray(libClassM);
        assertEquals(libfunCommonReturn.getCode(), LibfunCommonReturn.CODE_OK);
        Libclassm classM = Libclassm.dao.findFirst("select * from libfun_libclassm where ClassNo = 'hello'");
        assertNotNull(classM.get("seqid"));

        // 判断编号是否已经存在
        Libclassm libClassM1 = new Libclassm();
        libClassM1.set("ClassNo", "hello");
        libClassM1.set("ClassName", "我是一个测试数组");
        LibfunCommonReturn commonReturn = libArrayBo.insertLibArray(libClassM1);
        assertEquals(commonReturn.getMessage(), "编号已经存在,请换一个试试!");

        // 清除数据
        classM.delete();
    }

    @Test
    public void updateLibArrayTest() {
        //获取数据
        Libclassm classM = getLibClassM();

        Libclassm libClassM = new Libclassm();
        libClassM.set("seqid", classM.get("seqid"));
        libClassM.set("ClassName", "我被修改了");
        LibfunCommonReturn libfunCommonReturn = libArrayBo.updateLibArray(libClassM);
        assertEquals(libfunCommonReturn.getCode(), LibfunCommonReturn.CODE_OK);

        Libclassm classM1 = Libclassm.dao.findFirst("select * from libfun_libclassm where seqid = ?", classM.get("seqid"));
        assertEquals(classM1.getStr("ClassName"), libClassM.getStr("ClassName"));

        // 用户试图更改classNo 时,先判断classNo 是否已经存在
        Libclassm libClassM1 = new Libclassm();
        libClassM1.set("ClassNo", "goodtest");
        libClassM1.set("ClassName", "我是一个测试数组");
        boolean save = libClassM1.save();
        assertTrue(save);
        Object seqid = libClassM1.get("seqid");
        Libclassm classM2 = new Libclassm();
        classM2.set("seqid", seqid);
        classM2.set("ClassNo", classM.get("ClassNo"));
        classM2.set("ClassName", "我被修改了");
        LibfunCommonReturn commonReturn = libArrayBo.updateLibArray(classM2);
        assertEquals(commonReturn.getMessage(),"编号已经存在");

        //清除数据
        libClassM1.delete();
        classM1.delete();

    }

    @Test
    public void deleteLibArrayTest() {
        //获取数据
        Libclassm classM = getLibClassM();

        String classNo = classM.getStr("classNo");
        LibfunCommonReturn libfunCommonReturn = libArrayBo.deleteLibArray(classNo);
        assertEquals(libfunCommonReturn.getCode(), LibfunCommonReturn.CODE_OK);
        Libclassm libClassM = Libclassm.dao.findFirst("select * from libfun_libclassm where classNo = ?", classM.get("classNo"));
        List<Libclassd> libClassDs = Libclassd.dao.find("select * from libfun_libclassd where classNo = ?", classM.get("classNo"));

        assertTrue(libClassDs.size() == 0);
        assertNull(libClassM);
    }

    @Test
    public void insertArrayItemTest() {
        Libclassd libClassD = new Libclassd();
        libClassD.set("ClassNo", "abcdgood");
        libClassD.set("ItemNo", "heihei");
        libClassD.set("ItemName", "嘿嘿");
        libClassD.set("ItemOrder", "123");
        libClassD.set("ItemValue", "hehe");
        String userName = "panpan";
        LibfunCommonReturn libfunCommonReturn = libArrayBo.insertArrayItem(libClassD, userName);
        assertEquals(libfunCommonReturn.getCode(), LibfunCommonReturn.CODE_OK);

        Libclassd classNo = Libclassd.dao.findFirst("select * from libfun_libclassd where ClassNo = ?", libClassD.get("ClassNo"));
        assertNotNull(classNo.get("seqid"));

        //判断编号是否已经存在
        Libclassd libClassD1 = new Libclassd();
        libClassD1.set("ClassNo", "abcdgood");
        libClassD1.set("ItemNo", "heihei");
        libClassD1.set("ItemName", "嘿嘿");
        libClassD1.set("ItemOrder", "123");
        libClassD1.set("ItemValue", "hehe");
        String userName1 = "panpan";
        LibfunCommonReturn commonReturn = libArrayBo.insertArrayItem(libClassD1, userName1);
        assertEquals(commonReturn.getMessage(), "编号已经存在");

        //清除数据
        classNo.delete();
    }

    @Test
    public void updateArrayItemTest() {

        //获取数据
        Libclassd classD = getLibClassD();

        Libclassd libClassD = new Libclassd();
        libClassD.set("seqid", classD.get("seqid"));
        libClassD.set("ItemName", "嘿嘿2");
        libClassD.set("remark", "这个是啥");
        String userName = "panpan";
        LibfunCommonReturn libfunCommonReturn = libArrayBo.updateArrayItem(libClassD, userName);
        assertEquals(libfunCommonReturn.getCode(), LibfunCommonReturn.CODE_OK);

        Libclassd classD1 = Libclassd.dao.findFirst("select * from libfun_libclassd where seqid = ?", classD.get("seqid"));
        assertEquals(classD1.getStr("ItemName"), libClassD.getStr("ItemName"));
        assertEquals(classD1.getStr("remark"), libClassD.getStr("remark"));

        // 用户试图更改ItemNo 时,先判断ItemNo 是否已经存在
        Libclassd classD2 = new Libclassd();
        classD2.set("ItemName", "原来的");
        classD2.set("remark", "测试");
        classD2.set("ItemNo", "gaga");
        classD2.set("ClassNo", "heihei");
        classD2.set("ItemOrder", "123");
        classD2.set("ItemValue", "hehe");
        boolean save = classD2.save();
        assertTrue(save);
        Object seqid = classD2.get("seqid");
        Libclassd classD3 = new Libclassd();
        classD3.set("seqid", seqid);
        classD3.set("ItemNo", classD1.get("ItemNo"));
        classD3.set("ItemName", "嘿嘿2");
        LibfunCommonReturn commonReturn = libArrayBo.updateArrayItem(classD3,userName);
        assertEquals(commonReturn.getMessage(),"编号已经存在");


        // 清除数据
        classD2.delete();
        classD1.delete();
    }

    private Libclassd getLibClassD() {
        Libclassd libClassD = new Libclassd();
        libClassD.set("ItemName", "原来的");
        libClassD.set("remark", "测试");
        libClassD.set("ItemNo", "heihei");
        libClassD.set("ClassNo", "abcdgood");
        libClassD.set("ItemOrder", "123");
        libClassD.set("ItemValue", "hehe");
        boolean save = libClassD.save();
        assertTrue(save);

        assertNotNull(libClassD.get("seqid"));
        return libClassD;

    }
    private Libclassm getLibClassM() {
        Libclassm libClassM = new Libclassm();
        libClassM.set("ClassNo", "hello");
        libClassM.set("ClassName", "我是一个测试数组");
        boolean save = libClassM.save();
        assertTrue(save);

        assertNotNull(libClassM.get("seqid"));
        return libClassM;
    }

}
