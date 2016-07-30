package com.foxdsp.libfun.bo;

import com.foxdsp.common.util.lang.DateStringUtil;
import com.jfinal.plugin.activerecord.Db;
import com.foxdsp.libfun.model.Libclassd;
import com.foxdsp.libfun.model.Libclassm;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.util.LibFunConfig;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

/**
 * 系统数组维护
 * Created by panpan
 * on 15/12/28.
 */
@Component
public class LibArrayBoImpl implements LibArrayBo  {

    @Override
    public LibfunCommonReturn insertLibArray(Libclassm libClassM) {
        if (libClassM == null) {
            return LibfunCommonReturn.genErrorReturn("没有可以添加的数组");
        }
        Libclassm classno = Libclassm.dao.findFirst("select * from libfun_libclassm where classno = ?",
                libClassM.getStr("classno"));
        if (classno != null) {
            return  LibfunCommonReturn.genErrorReturn("编号已经存在,请换一个试试!");
        }
        boolean save = libClassM.save();
        if (save) {
            return LibfunCommonReturn.genOkReturn();
        } else {
            return LibfunCommonReturn.genErrorReturn("添加数组失败!");
        }
    }

    @Override
    public LibfunCommonReturn updateLibArray(Libclassm libClassM) {

        if (libClassM == null) {
            return LibfunCommonReturn.genErrorReturn("没有可以更新的数组");
        }
        Libclassm classno = Libclassm.dao.findFirst("select * from libfun_libclassm where classno = ?",
                libClassM.getStr("classno"));
        Libclassm seqid = Libclassm.dao.findFirst("select * from libfun_libclassm where seqid = ?",
                libClassM.getLong("seqid"));
        if (!(classno == null || StringUtils.equals(classno.getStr("classno"), seqid.getStr("classno")))) {
            return LibfunCommonReturn.genErrorReturn("编号已经存在");
        }
        boolean update = libClassM.update();
        if (update) {
            return LibfunCommonReturn.genOkReturn();
        } else {
            return LibfunCommonReturn.genErrorReturn("更新数组失败!");
        }
    }

    @Override
    public LibfunCommonReturn deleteLibArray(String classNo) {
        if (StringUtils.isBlank(classNo)) {
            return LibfunCommonReturn.genErrorReturn("编号不存在!");
        }
        Libclassm classM = Libclassm.dao.findFirst("select * from libfun_Libclassm where classno = ?", classNo);
        if (classM == null) {
            return LibfunCommonReturn.genErrorReturn("此数组不存在!");
        }
        Db.deleteById("libfun_libclassd", "classno", classNo);
        boolean delete = classM.delete();
        if (delete) {
            return LibfunCommonReturn.genOkReturn();
        } else {
            return LibfunCommonReturn.genErrorReturn("删除数组维护失败!");
        }
    }

    @Override
    public LibfunCommonReturn insertArrayItem(Libclassd libClassD, String userName) {
        if (libClassD == null) {
            return LibfunCommonReturn.genErrorReturn("没有可以添加的内容");
        }

        Libclassd itemno = Libclassd.dao.findFirst("select * from libfun_libclassd where ItemNo = ? and classno=?",
                libClassD.getStr("itemno"), libClassD.getStr("classno"));
        if (itemno != null) {
            return LibfunCommonReturn.genErrorReturn("编号已经存在");
        }
        libClassD.set("ClassItemId",libClassD.getStr("classno")+libClassD.getStr("itemno"));
        libClassD.set("editby", userName);
        libClassD.set("edittime", DateStringUtil.nowUnsafe());
        boolean save = libClassD.save();
        //需要重新更新缓存
        LibFunConfig.reloadLibclass();
        if (save) {
            return LibfunCommonReturn.genOkReturn();
        } else {
            return LibfunCommonReturn.genErrorReturn("添加数组子项失败!");
        }
    }

    @Override
    public LibfunCommonReturn updateArrayItem(Libclassd libClassD, String userName) {
        if (libClassD == null) {
            return LibfunCommonReturn.genErrorReturn("没有可以更新的内容");
        }
        Libclassd itemno = Libclassd.dao.findFirst("select * from libfun_libclassd where ItemNo = ? ",
                libClassD.getStr("itemno"));
        Libclassd seqidClassD = Libclassd.dao.findFirst("select * from libfun_libclassd where seqid = ? ",
                libClassD.getLong("seqid"));
        if (!(itemno == null || StringUtils.equals(itemno.getStr("itemno"), seqidClassD.getStr("itemno")))) {
            return LibfunCommonReturn.genErrorReturn("编号已经存在");
        }
        libClassD.set("editby", userName);
        libClassD.set("edittime", DateStringUtil.nowUnsafe());
        libClassD.set("classitemid", "");
        boolean update = libClassD.update();
        //需要重新更新缓存
        LibFunConfig.reloadLibclass();
        if (update) {
            return LibfunCommonReturn.genOkReturn();
        } else {
            return LibfunCommonReturn.genErrorReturn("添加数组子项失败!");
        }
    }

}
