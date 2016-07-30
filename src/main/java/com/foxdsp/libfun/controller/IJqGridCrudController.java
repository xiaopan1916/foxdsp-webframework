package com.foxdsp.libfun.controller;

/**
 * Created by briceli on 15/8/31.
 * 封装了 单表 增删改查crud操作的 controller
 */
public interface IJqGridCrudController<T> {
    void jqGridQuery();
    void jqGridEdit();
}
