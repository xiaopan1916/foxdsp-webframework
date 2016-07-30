package com;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.activerecord.CaseInsensitiveContainerFactory;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.foxdsp.libfun.JfinalConfig;
import com.foxdsp.libfun.model.*;
import com.mysql.jdbc.jdbc2.optional.MysqlDataSource;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.junit.Before;
import org.junit.BeforeClass;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DataSourceUtils;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;


import javax.sql.DataSource;
import java.sql.DatabaseMetaData;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;


@ContextConfiguration(locations = "classpath:applicationContext.xml")
//------------如果加入以下代码，所有继承该类的测试类都会遵循该配置，也可以不加，在测试类的方法上///控制事务，参见下一个实例
//这个非常关键，如果不加入这个注解配置，事务控制就会完全失效！
//@Transactional
//这里的事务关联到配置文件中的事务控制器（transactionManager = "transactionManager"），同时//指定自动回滚（defaultRollback = true）。这样做操作的数据才不会污染数据库！
//@TransactionConfiguration(transactionManager = "transactionManager", defaultRollback = true)
//------------
@Transactional
@TransactionConfiguration(transactionManager = "txManager", defaultRollback = true)
public abstract class BaseTest extends AbstractJUnit4SpringContextTests {

    public static final String SEPARATOR = ",";
    public static final String EMPTY = "";
    public static final int CPMCOUNT = 1000;//cpm*1000
    public static final int PRICECOUNT = 100;//价格*100
    protected Random random = new Random();

    protected SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");

    protected Map<String,String> configData = new HashMap<String,String>(0);

    public <T> T getBean(Class<T> type) {
        return applicationContext.getBean(type);
    }

    public Object getBean(String beanName) {
        return applicationContext.getBean(beanName);
    }

    protected ApplicationContext getContext() {
        return applicationContext;
    }

    public static final String SEQID = "seqid";

    static {

        PropKit.use("config.properties");
        String host = PropKit.get("libfun.mysql.host");
        String database = PropKit.get("db.name");
        String user = PropKit.get("libfun.mysql.user");
        String password = PropKit.get("libfun.mysql.password");
        String port = PropKit.get("libfun.mysql.port");
        String dbTest = PropKit.get("db.unittest");

        //写死单元测试的数据库名字unittest_admin
        C3p0Plugin c3p0Plugin = new C3p0Plugin("jdbc:mysql://" + host + ":" +
                port + "/"+dbTest+"?characterEncoding=utf8", user, password);
        c3p0Plugin.start();
        EhCachePlugin ehCachePlugin = new EhCachePlugin();
        ehCachePlugin.start();
        ActiveRecordPlugin arp = JfinalConfig.getActiveRecordPlugin(c3p0Plugin);
        arp.start();
    }

    //@Before
    public void checkDB() {
        DatabaseMetaData meta = null;
        String url = null ;
        try {
            meta = DataSourceUtils.getConnection((DataSource) getBean("dataSource")).getMetaData();
            url = meta.getURL();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String testDbPreName = "unittest_";
        String dbName = null ;
        boolean passed = false ;
        //1.判断dataSource 的数据库配置
        if (StringUtils.isNoneBlank(url)) {
            String[] urlParms = url.split("\\/");
            if (null != urlParms && urlParms.length >= 3) {
                dbName = urlParms[3];
                if (StringUtils.isNoneBlank(dbName)) {
                    if ( !dbName.startsWith(testDbPreName) ) {
                        logger.error(String.format("异常,当前数据库名字为%s,不符合规范!",dbName));
                    } else {
                        passed = true;
                        logger.info(String.format("当前数据库名字为%s,符合规范!",dbName));
                    }
                }
            }
        }

        if ( !passed ) {
            System.exit(1);
        }

    }

    @BeforeClass
    public static void initJFinal() { //初始化jFinal


    }


    //模拟创建排期的数据 添加排期的时候需要
    protected JSONObject mockAddPlanScheduleList(Map<String, String> stringMap) {
//        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//        Calendar start = Calendar.getInstance();
//        Calendar end = Calendar.getInstance();
//        try {
//            start.setTime(format.parse(playdateStart));
//            end.setTime(format.parse(playdateEnd));
//        } catch (ParseException e) {
//            //e.printStackTrace();
//            logger.error(e);
//        }
//
//        int turnseq1 = 0;
//        int turnseq2 = 0;
//        try {
//            turnseq1 = Db.queryInt("select max(turnseq) from adorderplan");
//            turnseq2 = Db.queryInt("select max(turnseq) from adorderplanhis");
//        } catch (Exception e) { //数据库没有数据会抛异常
//            //e.printStackTrace();
//        }
//        int turnseq = Math.max(turnseq1,turnseq2) + 1;
//        List<String> list = new ArrayList<String>();
//        while(!start.after(end)){
//            //3736~8~2015-12-17,3736~8~2015-12-18,3736~8~2015-12-19
//            String playdate = format.format(start.getTime());
//            StringBuilder sb = new StringBuilder();
//            sb.append(positionid).append("~");
//            sb.append(turnseq).append("~");
//            sb.append(playdate);
//            list.add(sb.toString());
//            start.add(Calendar.DAY_OF_MONTH,1);
//        }
//
//        return StringUtils.join(list,SEPARATOR);


        JSONObject jsonObj = new JSONObject();
        jsonObj.put("orderid",stringMap.get("orderid"));
        JSONArray datas = new JSONArray();
        JSONObject jsonObjData0 = new JSONObject();
        jsonObjData0.put("startDate",stringMap.get("startDate") );
        jsonObjData0.put("endDate",stringMap.get("endDate") );
        JSONArray positionArr = new JSONArray();
        for(String s : stringMap.get("positionids").split(",") ) {
            positionArr.add(s);
        }
        JSONArray areaArr = new JSONArray();
        //for(String s : stringMap.get("areas").split(",") ) {
            areaArr.add(stringMap.get("areas"));
        //}
        jsonObjData0.put("positionids",positionArr );
        jsonObjData0.put("areas",areaArr);
        jsonObjData0.put("hours",stringMap.get("hours"));
        jsonObjData0.put("cpm",stringMap.get("cpm") );
        jsonObjData0.put("cpmlength",stringMap.get("cpmlength") );
        jsonObjData0.put("pushratio",stringMap.get("pushratio"));
        datas.add(jsonObjData0);
        jsonObj.put("data",datas);
        return jsonObj;

//        var postData = {
//                'data':datas,
//                'orderid':$("#orderId").val() //待研究
//        };

//        datas.push({
//                startDate:$('#startTime'+index).val(),
//                endDate:$('#endTime'+index).val(),
//                positionids:positions,
//                areas:area,
//                hours:hours.join(","),
//                cpm:totalCpmNum,
//                pushratio:pushratio
//        });

    }





}