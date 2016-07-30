package com.foxdsp.libfun;

import com.jfinal.kit.PathKit;
import com.jfinal.kit.PropKit;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.xslf.model.geom.Path;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;


/**创建db ,初始化sql
 * Created by panpan
 * on 16/7/9.
 */
public class Install {
    static {
        PropKit.use("config.properties");
    }
    public static void main(String[] args) {
        String host = PropKit.get("libfun.mysql.host");
        String database = PropKit.get("libfun.mysql.db");
        String user = PropKit.get("libfun.mysql.user");
        String password = PropKit.get("libfun.mysql.password");
        String port = PropKit.get("libfun.mysql.port");
        String projectDir = System.getProperty("user.dir");
        try {
            List<String> stringList = readSql(projectDir + "/sql/foxdsp-webframework_init.sql");
            System.out.println(stringList);
            createDb(host, port, database, user, password);
            createTable(host, port, database, user, password,
                    stringList);

            System.out.println("初始化成功。。。");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static Connection getConn(String dbHost, String dbPort,
                                      String dbName, String dbUser, String dbPassword) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connStr = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
                + "?user=" + dbUser + "&password=" + dbPassword
                + "&characterEncoding=utf8&autoReconnect=true";
        Connection conn = DriverManager.getConnection(connStr);
        return conn;
    }
    private static void createDb(String dbHost, String dbPort, String dbName,
                                 String dbUser, String dbPassword) throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Class.forName("com.mysql.jdbc.Driver").newInstance();
        String connStr = "jdbc:mysql://" + dbHost + ":" + dbPort + "?user="
                + dbUser + "&password=" + dbPassword
                + "&characterEncoding=utf8&autoReconnect=true";
        Connection conn = DriverManager.getConnection(connStr);
        Statement stat = conn.createStatement();
        String sql = "drop database if exists " + dbName;
        stat.execute(sql);
        sql = "create database " + dbName + " CHARACTER SET UTF8";
        stat.execute(sql);
        stat.close();
        conn.close();
    }
    private static void createTable(String dbHost, String dbPort, String dbName,
                                    String dbUser, String dbPassword, List<String> sqlList)
            throws Exception {
        Connection conn = getConn(dbHost, dbPort, dbName, dbUser, dbPassword);
        Statement stat = conn.createStatement();
        for (String dllsql : sqlList) {
            System.out.println(dllsql);
            stat.execute(dllsql);
        }
        stat.close();
        conn.close();
    }
    private static List<String> readSql(String fileName) throws Exception {
        BufferedReader br = new BufferedReader(new InputStreamReader(
                new FileInputStream(fileName), "UTF-8"));
        List<String> sqlList = new ArrayList<String>();
        StringBuilder sqlSb = new StringBuilder();
        String s = null;
        while ((s = br.readLine()) != null) {
            if (s.startsWith("/*") || s.startsWith("#")
                    || StringUtils.isBlank(s)) {
                continue;
            }
            if (s.endsWith(";")) {
                sqlSb.append(s);
                sqlSb.setLength(sqlSb.length() - 1);
                sqlList.add(sqlSb.toString());
                sqlSb.setLength(0);
            } else {
                sqlSb.append(s);
            }
        }
        br.close();
        return sqlList;
    }
}
