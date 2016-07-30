package com.foxdsp.libfun.controller;

import com.alibaba.fastjson.JSONObject;
import com.foxdsp.common.util.lang.DateStringUtil;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Table;
import com.jfinal.plugin.activerecord.TableMapping;
import com.foxdsp.libfun.bo.CrudBo;
import com.foxdsp.libfun.vo.DataTableQueryInfo;
import com.foxdsp.libfun.vo.LibfunCommonReturn;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.BufferedReader;
import java.io.IOException;
import java.lang.reflect.ParameterizedType;
import java.util.Map;

/**
 * Created by briceli on 15/9/10.
 */
public abstract class CrudController<T extends Model<T>> extends BaseController {
    @Autowired
    protected CrudBo<T> crudBo = ctx.getBean(CrudBo.class);

    abstract public void index();

    public void delete() {
        Map<String, String[]> paraMap = getParaMap();
        T model = null;
        try {
            model = getTClass().newInstance();
        } catch (Exception e) {
            e.printStackTrace();
            renderJson(LibfunCommonReturn.genErrorReturn(e.getMessage()));
        }
        for (String key : paraMap.keySet()) {
            model.put(key, paraMap.get(key)[0]);
        }
        crudBo.delete(model);
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    public void update() {
        T obj = getModel(getTClass(), "editObj");
        crudBo.update(obj);
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    public void updateWithoutEdit() {
        updateInner(false);
    }

    private void updateInner(boolean update) {
        T obj = getModel(getTClass(), "editObj");
        if (update) {
            obj.set("editby", getUserNameLogo());
            obj.set("edittime", DateStringUtil.nowUnsafe());
        }
        obj.update();
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    public void insert() {
        T obj = getModel(getTClass(), "editObj");
        crudBo.insert(obj);
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    public void insertWithoutEdit() {
        insertInner(false);
    }

    private void insertInner(boolean edit) {
        T obj = getModel(getTClass(), "editObj");
        if (edit) {
            obj.set("editby", getUserNameLogo());
            obj.set("edittime", DateStringUtil.nowUnsafe());
        }
        obj.save();
        renderJson(LibfunCommonReturn.genOkReturn());
    }

    /**
     * 封装了增删改查，对于存在的字段int=？ string like '%?%' and连接所有条件
     */
    public void query() {
        Table table = TableMapping.me().getTable(getTClass());
        DataTableQueryInfo queryInfo = new DataTableQueryInfo(getParaMap());
        T queryObj = getModel(getTClass(), "queryObj");
        renderJson(JsonKit.toJson(crudBo.query(queryInfo, queryObj)));
    }

    protected Class<T> getTClass() {
        return (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
    }

    protected JSONObject getJsonObj() {
        StringBuilder json = new StringBuilder();
        try {
            BufferedReader reader = this.getRequest().getReader();
            String line = null;
            while((line = reader.readLine()) != null){
                json.append(line);
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        JSONObject jsonObj = JSONObject.parseObject(json.toString());
        return jsonObj;
    }
}
