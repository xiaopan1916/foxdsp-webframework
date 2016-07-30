package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.vo.LibfunCommonReturn;
import com.foxdsp.libfun.model.Libconfig;

/**
 * Created by panpan
 * on 15/12/28.
 */
public interface LibConfigBo {

    /** 增加系统配置
     * @param libConfig 系统配置
     * @return 执行结果
     */
    LibfunCommonReturn insertLibConfig(Libconfig libConfig);
}
