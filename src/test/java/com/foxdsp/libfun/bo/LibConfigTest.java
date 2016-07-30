package com.foxdsp.libfun.bo;

import com.BaseTest;

import com.foxdsp.libfun.model.Libconfig;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import static org.junit.Assert.*;

/** 系统配置测试
 * Created by panpan
 * on 15/12/28.
 */
public class LibConfigTest extends BaseTest {

    @Autowired
    private LibConfigBo libConfigBo;

    @Test
    public void insertLibConfigTest() {

        Libconfig libconfig = new Libconfig();
        libconfig.set("ConfigNo", "aba");
        libconfig.set("ConfigName", "这个是有用的名称");
        libconfig.set("ConfigValue", "123");
        LibfunCommonReturn libfunCommonReturn = libConfigBo.insertLibConfig(libconfig);
        assertEquals(libfunCommonReturn.getMessage(), libfunCommonReturn.getCode(), LibfunCommonReturn.CODE_OK);

        Libconfig config = Libconfig.dao.findFirst("select * from libfun_libconfig where " +
                "configNo = ? and ConfigName = ? and ConfigValue = ?",libconfig.get("ConfigNo"),
                libconfig.get("ConfigName"),libconfig.get("ConfigValue"));
        assertNotNull(config.get("seqid"));

        // 判断编号是否存在
        Libconfig libconfig1 = new Libconfig();
        libconfig1.set("ConfigNo", "aba");
        libconfig1.set("ConfigName", "这个是有用的名称");
        libconfig1.set("ConfigValue", "123");
        LibfunCommonReturn commonReturn = libConfigBo.insertLibConfig(libconfig1);
        assertEquals(commonReturn.getMessage(), "编号已存在");

        // 清除数据
        config.delete();
    }

    @Test
    public void updateLibConfigTest() {
        //获取数据
        Libconfig config = getConfig();

        Libconfig libconfig = new Libconfig();
        libconfig.set("seqid", config.get("seqid"));
        libconfig.set("ConfigName", "这个是修改的名称");
        boolean update = libconfig.update();
        assertTrue(update);
        Libconfig firstConfig = Libconfig.dao.findFirst("select * from libfun_libconfig where seqid = ?", config.get("seqid"));
        assertEquals(firstConfig.get("ConfigName"),libconfig.getStr("ConfigName"));

        //清除数据
        firstConfig.delete();

    }

    @Test
    public void deleteLibConfigTest() {
        //获取数据
        Libconfig config = getConfig();

        Libconfig libconfig = new Libconfig();
        libconfig.set("seqid", config.get("seqid"));

        boolean delete = libconfig.delete();
        assertTrue(delete);

        Libconfig libFig = Libconfig.dao.findById(config.get("seqid"));
        assertNull(libFig);

    }

    private Libconfig getConfig() {
        Libconfig config = new Libconfig();
        config.set("ConfigNo", "abcde");
        config.set("ConfigName", "测试名称");
        config.set("ConfigValue", "123456");
        boolean save = config.save();

        assertTrue(save);
        assertNotNull(config.get("seqid"));

        return config;
    }
}
