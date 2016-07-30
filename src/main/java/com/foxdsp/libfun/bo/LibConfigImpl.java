package com.foxdsp.libfun.bo;

import com.jfinal.plugin.activerecord.Db;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.model.Libconfig;
import org.springframework.stereotype.Component;

/**
 * 系统配置
 * Created by panpan
 * on 15/12/28.
 */
@Component
public class LibConfigImpl implements LibConfigBo {


    @Override
    public LibfunCommonReturn insertLibConfig(Libconfig libConfig) {
        boolean hasSameNo = Db.findFirst("select count(*) as " +
                "count from libfun_libconfig where configno = ?", libConfig.get("configno")).getLong("count") > 0;
        if (hasSameNo) {
            return LibfunCommonReturn.genErrorReturn("编号已存在");
        }
        boolean save = libConfig.save();
        if (save) {
            return LibfunCommonReturn.genOkReturn();
        }
        return LibfunCommonReturn.genErrorReturn("添加系统配置失败!");
    }
}
