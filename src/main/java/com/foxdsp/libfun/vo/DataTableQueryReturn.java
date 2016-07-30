package com.foxdsp.libfun.vo;

import com.jfinal.plugin.activerecord.Page;

import java.util.List;

/**
 * Created by briceli on 15/9/8.
 */
public class DataTableQueryReturn<T> extends LibfunCommonReturn<List<T>>{
    private int draw;
    private int recordsTotal;
    private int recordsFiltered;

    public DataTableQueryReturn(Page<T> page, int draw) {
        this.draw = draw;
        this.recordsFiltered = this.recordsTotal = page.getTotalRow();
        this.setData(page.getList());
        this.setCode(CODE_OK);
    }

    public int getDraw() {
        return draw;
    }

    public void setDraw(int draw) {
        this.draw = draw;
    }

    public int getRecordsTotal() {
        return recordsTotal;
    }

    public void setRecordsTotal(int recordsTotal) {
        this.recordsTotal = recordsTotal;
    }

    public int getRecordsFiltered() {
        return recordsFiltered;
    }

    public void setRecordsFiltered(int recordsFiltered) {
        this.recordsFiltered = recordsFiltered;
    }

}
