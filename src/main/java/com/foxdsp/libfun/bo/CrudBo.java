package com.foxdsp.libfun.bo;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Table;
import com.jfinal.plugin.activerecord.TableMapping;
import com.foxdsp.libfun.vo.DataTableQueryInfo;
import com.foxdsp.libfun.vo.DataTableQueryReturn;
import org.apache.commons.beanutils.converters.IntegerConverter;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

/**
 * Created by briceli on 15/12/29.
 */
@Component
public class CrudBo<T extends Model<T>> extends BaseBo {
    public void delete(T model) {
        model.delete();
    }

    public void update(T obj) {
        obj.update();
    }

    public void insert(T obj) {
        obj.save();
    }

    /**
     * @param queryInfo
     * @param queryObj  对于model/vo内存在的字段 使用 int=？ string like '%?%' and 连接所有条件
     * @return
     */
    public DataTableQueryReturn<T> query(DataTableQueryInfo queryInfo, T queryObj) {
        Table table = TableMapping.me().getTable(queryObj.getClass());
        String[] whereStrs = new String[queryObj._getAttrNames().length];
        Object[] attrArr = new Object[queryObj._getAttrNames().length];
        for (int i = 0; i < queryObj._getAttrNames().length; i++) {
            String attrName = queryObj._getAttrNames()[i];
            if (table.getColumnType(attrName) == String.class) {
                whereStrs[i] = attrName + " like ? ";
                attrArr[i] = "%" + (queryObj.get(attrName) == null ? "" : queryObj.get(attrName)) + "%";
            } else if (table.getColumnType(attrName) == Integer.class) {
                if (queryObj.get(attrName) == null) {
                    whereStrs[i] = attrName + " > ? ";
                    attrArr[i] = Integer.MIN_VALUE+" and " +Integer.MAX_VALUE+" > "+ attrName;
                } else {
                    whereStrs[i] = attrName + " = ? ";
                    attrArr[i] = queryObj.get(attrName);
                }
            } else {
                whereStrs[i] = attrName + " = ? ";
                attrArr[i] = queryObj.get(attrName);
            }
        }

        String sqlExceptSelect = "from " + table.getName() + (queryObj._getAttrNames().length > 0 ? " where " + StringUtils.join(whereStrs, " and ") : "") + queryInfo.getOrderStr();



        Page<T> page = queryObj.paginate(queryInfo.getPageNumber()
                , queryInfo.getPageSize() < 0 ? Integer.MAX_VALUE : queryInfo.getPageSize()
                , "select *"
                , sqlExceptSelect
                , attrArr);
        return new DataTableQueryReturn(page, queryInfo.getSeq());
    }

//    protected Class<T> getTClass() {
//        return (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0];
//    }
}
