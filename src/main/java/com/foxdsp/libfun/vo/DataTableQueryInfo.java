package com.foxdsp.libfun.vo;

import org.apache.commons.lang3.StringUtils;

import java.util.Map;

/**
 * Created by briceli on 15/9/8.
 */
public class DataTableQueryInfo {
    private String sortName;
    private String sortOrder;
    private int pageNumber = 1;
    private int seq;
    private int pageSize = 50;

    public DataTableQueryInfo(Map<String, String[]> paraMap) {
        seq = Integer.parseInt(paraMap.get("draw")[0]);
        pageSize = Integer.parseInt(paraMap.get("length")[0]);
        int start = Integer.parseInt(paraMap.get("start")[0]);
        pageNumber = start / pageSize + 1;

        String orderColumn = paraMap.get("order[0][column]")[0];
        if(StringUtils.isNotEmpty(orderColumn)){
            sortOrder = paraMap.get("order[0][dir]")[0];
            sortName = paraMap.get("columns[" + orderColumn + "][data]")[0];
        }
    }

    public String getSortName() {
        return sortName;
    }

    public void setSortName(String sortName) {
        this.sortName = sortName;
    }

    public String getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(String sortOrder) {
        this.sortOrder = sortOrder;
    }

    public String getOrderStr(){
        return StringUtils.isNotEmpty(sortName) ? " order by " + sortName + " " + sortOrder + " " : "";
    }

    public int getPageNumber() {
        return pageNumber;
    }

    public void setPageNumber(int pageNumber) {
        this.pageNumber = pageNumber;
    }

    public int getSeq() {
        return seq;
    }

    public void setSeq(int seq) {
        this.seq = seq;
    }

    public int getPageSize() {

        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }
}
