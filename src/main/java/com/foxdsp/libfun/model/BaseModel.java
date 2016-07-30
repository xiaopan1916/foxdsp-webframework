package com.foxdsp.libfun.model;

import com.jfinal.plugin.activerecord.Model;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by briceli on 15/8/25.
 */
public class BaseModel<T extends Model> extends Model<T> {

    public static <M extends Model> List<M> findObjects(Class<M> clazz, String exwheresql, String orderbysql) {
        StringBuilder sql = new StringBuilder(" select *  from ").append(clazz.getSimpleName()).append(" where 1 = 1 ");
        if( StringUtils.isNotEmpty(exwheresql) ){
            sql.append(" and ").append(exwheresql).append(" ");
        }
        if( StringUtils.isNotEmpty(orderbysql) ){
            sql.append(" order by ").append(orderbysql);
        }
        try {
            Model model = (Model) clazz.getDeclaredField("dao").get(null);
            return model.find(sql.toString());
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
        return new ArrayList(0);
    }


    public static <M extends Model> M findObject(Class<M> clazz,String exwheresql,String orderbysql) {
        List<M>  list = findObjects(clazz,exwheresql,orderbysql);
        if ( list != null && list.size() > 0 ) {
            return list.get(0);
        }
        return null;
    }

    public static String getSQLForIn(int size) { //获取in填充的问号
        String[] a = new String[size];
        for(int i = 0 ; i < size ;i++) {
            a[i] = "?";
        }
        return StringUtils.join(a,",");
    }


}
