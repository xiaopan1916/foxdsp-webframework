package com.foxdsp.libfun.vo;


import com.foxdsp.common.util.lang.StringUtil;

/**
 * @author Brice Li
 * 此类包含框架表基本字段
 */
public class BaseVO {
	@Override
    public String toString(){
        return StringUtil.listingString(this);
    }
}
