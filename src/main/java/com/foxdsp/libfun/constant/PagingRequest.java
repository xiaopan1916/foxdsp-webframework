package com.foxdsp.libfun.constant;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


import org.apache.commons.lang3.StringUtils;

/**
 * 分页请求信息
 *  Created by panfenquan
 * 2015/8/30
 */
public class PagingRequest implements Serializable {

    /** serialVersionUID */
    private static final long   serialVersionUID   = -6537871581972777911L;

    /** 每页条数 */
    private Integer             pageSize           = 20;

    /** 第几页 */
    private int                 pageNumber          = 1;

    /** 排序的字段 */
    private String              orderItem;

    /** 排序类型 */
    private String              orderType;



    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        if (null != pageSize) {
            this.pageSize = pageSize;
        }
    }

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public String getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(String orderItem) {
        this.orderItem = orderItem;
    }

}
