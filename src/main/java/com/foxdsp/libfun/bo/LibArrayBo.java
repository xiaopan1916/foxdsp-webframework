package com.foxdsp.libfun.bo;

import com.foxdsp.libfun.model.Libclassd;
import com.foxdsp.libfun.model.Libclassm;
import com.foxdsp.libfun.vo.LibfunCommonReturn;

/**
 * 系统数组维护接口
 * Created by panpan
 * on 15/12/28.
 */
public interface LibArrayBo {

    /**
     * 添加数组维护内容
     *
     * @return 执行结果
     */
     LibfunCommonReturn insertLibArray(Libclassm libClassM);


    /**
     * 更新数组维护
     *
     * @param libClassM 需要更新的数组内容
     * @return 执行结果
     */
    LibfunCommonReturn updateLibArray(Libclassm libClassM);


    /**
     * 删除数组
     *
     * @param classNo 数组编号
     * @return 执行结果
     */
    LibfunCommonReturn deleteLibArray(String classNo);


    /**
     * 添加数组维护子项内容
     *
     * @param libClassD 数组维护子项
     * @param userName
     * @return 执行结果
     */
    LibfunCommonReturn insertArrayItem(Libclassd libClassD, String userName);

    /**更新数组维护子项
     * @param libClassD 数组子项
     * @param userName 用户名
     * @return 返回结果
     */
    LibfunCommonReturn updateArrayItem(Libclassd libClassD, String userName);



}
