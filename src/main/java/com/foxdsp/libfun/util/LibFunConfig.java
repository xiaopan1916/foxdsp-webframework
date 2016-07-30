package com.foxdsp.libfun.util;

import com.foxdsp.libfun.model.Libclassd;
import com.foxdsp.libfun.model.Libclassm;
import com.foxdsp.libfun.model.Libconfig;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

public final class LibFunConfig {
	private static Log logger = LogFactory.getLog("LibFunConfig");
	private static Map<String, Libconfig> LibconfigMap = null;
	private static Map<String, Map<String, Libclassd>> Libclassmap = null;
	
	/**
     * Libclassd  比较器
     * 
     */
	private static class ComparatorLibClass implements Comparator<Libclassd>{
    	 public int compare(Libclassd arg0, Libclassd arg1) {
    		 if(arg0.getItemOrder() == arg1.getItemOrder()){
    			 return arg0.getItemNo().compareTo(arg1.getItemNo());
    		 }
    		 return  arg0.getItemOrder() > (arg1.getItemOrder()) ? 1 : -1;
    	}
    }
	
	private LibFunConfig() {
		
	}

	/**
     * 载入 LibconfigMap，将系统常量读入缓存
     */
    public synchronized static void reloadLibconfig() {
    	logger.debug("load LibconfigMap start");
		Map<String, Libconfig> LibconfigMapTmp = new HashMap<String, Libconfig>();
	
		List<Libconfig> libs;
		//ILibconfigBo LibconfigBo = WebApplicationContextUtil.webApplicationContext.getBean(ILibconfigBo.class);
		libs = Libconfig.dao.find(" select *  from libfun_libconfig ");
		for (Libconfig lib : libs) {
			LibconfigMapTmp.put(lib.getConfigNo(), lib);
		}
		LibconfigMap = LibconfigMapTmp;
		logger.debug("load LibconfigMap over");		
    }
    
    public synchronized static void reloadLibclass() {
    	logger.debug("load LibconfigMap start");
//
//    	Libclassmap = new HashMap<String, Map<String,Libclassd>>();
//    	ILibclassmBo mbo = WebApplicationContextUtil.webApplicationContext.getBean(ILibclassmBo.class);
//    	ILibclassdBo dbo = WebApplicationContextUtil.webApplicationContext.getBean(ILibclassdBo.class);
//    	List<Libclassm> mList = mbo.getAllLibclassm();
//    	if(mList != null && mList.size() > 0){
//    		for(Libclassm m : mList){
//    			Map<String, Libclassd> tempMap = Libclassmap.get(m.getClassno());
//    			if(tempMap == null){
//    				tempMap = new HashMap<String, Libclassd>();
//    				Libclassmap.put(m.getClassno(), tempMap);
//
//    				List<Libclassd> dList = dbo.getLibclassdByClassNo(m.getClassno());
//    				if(dList != null && dList.size() > 0){
//    					for(Libclassd d : dList){
//    						if(tempMap.get(d.getItemno()) != null){
//    							logger.error("repeat itemno : " + m.getClassno() + "-" + d.getItemno());
//    						}else{
//    							tempMap.put(d.getItemno(), d);
//    						}
//    					}
//    				}
//    			}else{
//    				logger.error("repeat classno : " + m.getClassno());
//    			}
//    		}
//    	}

		Map<String, Map<String,Libclassd>> LibclassmapTmp = new HashMap<String, Map<String,Libclassd>>();
		//ILibclassmBo mbo = WebApplicationContextUtil.webApplicationContext.getBean(ILibclassmBo.class);
		List<Libclassm> mList = Libclassm.dao.find("select * from libfun_libclassm");
		if(mList != null && mList.size() > 0){
			for(Libclassm m : mList){
				Map<String, Libclassd>	tempMap = new HashMap<String, Libclassd>();
				LibclassmapTmp.put(m.getClassNo(), tempMap);
			}
		}
		//一次性查询出所有的Libclassd
		//IUtilDao utilDao = WebApplicationContextUtil.webApplicationContext.getBean(IUtilDao.class);
		List<Libclassd> dList = Libclassd.dao.find("select * from libfun_libclassd");
		if(dList != null && dList.size() > 0){
			for(Libclassd d : dList){
				Map<String, Libclassd> tempMap = LibclassmapTmp.get(d.getClassNo());
				if ( tempMap == null ) {
					continue ;
				}
				if(tempMap.get(d.getItemNo()) != null){
					logger.error("repeat itemno : " + d.getClassNo() + "-" + d.getItemNo());
				}else{
					tempMap.put(d.getItemNo(), d);
				}
			}
		}
		Libclassmap = LibclassmapTmp;


        logger.debug("load LibconfigMap over");
    }
    
    /**
     * 从缓存中取 configno 对应的 Libconfig 对象
     * @param configno  配置编号
     * @return Libconfig 对象
     */
    private synchronized static Libconfig getLibconfig(String configno) {
    	if(LibconfigMap == null)
    		reloadLibconfig();
    	return LibconfigMap.get(configno);
    }
    
    /**
     * 根据配置编号得到该系统常量的配置值
     * @param configno 配置编号
     * @return String型的系统常量配置值
     */
    public static String getString(String configno) {
        try{
        	return getLibconfig(configno).getConfigValue();
        }catch(Exception ex){
            return null;
        }
    }
    
    /**
     * 根据配置编号得到该系统常量的配置值，如果配置值为null则用默认值代替
     * @param configno 配置编号
     * @param defaultValue 默认的系统常量配置值
     * @return String型的系统常量配置值
     */
    public static String getString(String configno, String defaultValue) {
        String v = getString(configno);
        return (v == null) ? defaultValue : v;
    }
    
    /**
     * 根据配置编号得到该系统常量的配置值
     * @param configno 配置编号
     * @return int型的系统常量配置值
     */
    public static int getIntValue(String configno) {
        return  Integer.parseInt(getString(configno));
    }
    
    /**
     * 根据配置编号得到该系统常量的配置值，如果配置值为null则用默认值代替
     * @param configno 配置编号
     * @param defaultValue 默认的系统常量配置值
     * @return int型的系统常量配置值
     */
    public static int getIntValue(String configno, int defaultValue) {
        String v = getString(configno);
        return (v == null) ? defaultValue : Integer.parseInt(v);
    }
    
    /**
     * 根据配置编号得到该系统常量的配置值
     * @param configno 配置编号
     * @return float型的系统常量配置值
     */
    public static float getFloatValue(String configno) {
        return  Float.parseFloat(getString(configno));
    }
    
    /**
     * 根据配置编号得到该系统常量的配置值，如果配置值为null则用默认值代替
     * @param configno 配置编号
     * @param defaultValue 默认的系统常量配置值
     * @return float型的系统常量配置值
     */
    public static float getFloatValue(String configno, float defaultValue) {
        String v = getString(configno);
        return (v == null) ? defaultValue : Float.parseFloat(v);
    }
    
    public static boolean getBoolean(String configno) {
    	String v = getString(configno);
    	return (v == null) ? false : Boolean.parseBoolean(v);
    }
    
    public synchronized static List<Libclassd> getLibclassdList(String classno){
    	if(Libclassmap == null)
    		reloadLibclass();
    	List<Libclassd> lcdList = new ArrayList<Libclassd>();
    	Map<String, Libclassd> lcdMap = Libclassmap.get(classno);
    	if(lcdMap != null){
    		for(String key : lcdMap.keySet()){
    			lcdList.add(lcdMap.get(key));
    		}
    	}
    	return lcdList;
    }
    
    public synchronized static Map<String,Libclassd> getLibclassdMap(String classno){
    	if(Libclassmap == null)
    		reloadLibclass();
    	return  Libclassmap.get(classno);
    }
    
    /**
     * 根据classNo，itemNo查找数组项
     * @param classNo
     * @param itemNo
     * @return
     */
    public synchronized static Libclassd getLibclassd(String classNo,String itemNo) {
    	if(Libclassmap == null)
    		reloadLibclass();
    	Map<String, Libclassd> lcdMap = Libclassmap.get(classNo);
    	if(lcdMap != null){
    		return lcdMap.get(itemNo);
    	}
    	return null;
    }
    
    /**
     * 获取数组名对应的数组列表名
     * @param classNo
     * @return
     */
    public static List<String> getItemStringList(String classNo){
    	List<String> itemValueList = new ArrayList<String>();
    	List<Libclassd> lcdList = getLibclassdList(classNo);
    	
    	Collections.sort(lcdList, new ComparatorLibClass());
    	for(Libclassd lcd : lcdList){
    		itemValueList.add(lcd.getItemNo());
    	}
    	return itemValueList;
    }
    
    
    
	
	/**
     * 获取数组名对应的数组map
     * @param classNo
     * @return
     */
    public static Map<String,String> getMapNoValue(String classNo){
    	Map<String,String> itemMap = new TreeMap<String,String>();
    	List<Libclassd> lcdList = getLibclassdList(classNo);
    	
    	Collections.sort(lcdList, new ComparatorLibClass());
    	for(Libclassd lcd : lcdList){
    		itemMap.put(lcd.getItemNo(), lcd.getItemValue());
    	}
    	return itemMap;
    }
    
    /**
     * 获取数组名对应的数组map
     * @param classNo
     * @return
     */
    public static synchronized Map<String,String> getMapNoName(String classNo){

    	Map<String,String> itemMap = new TreeMap<String,String>();
    	List<Libclassd> lcdList = getLibclassdList(classNo);
    	
    	Collections.sort(lcdList, new ComparatorLibClass());
    	for(Libclassd lcd : lcdList){
    		itemMap.put(lcd.getItemNo(), lcd.getItemName());
    	}
    	return itemMap;
    }
    
    /**
     * 获取数组名对应的数组map
     * @param classNo
     * @return
     */
    public static synchronized Map<String,Integer> getMapNoOrder(String classNo){
    	Map<String,Integer> itemMap = new TreeMap<String,Integer>();
    	List<Libclassd> lcdList = getLibclassdList(classNo);
    	
    	Collections.sort(lcdList, new ComparatorLibClass());
    	for(Libclassd lcd : lcdList){
    		itemMap.put(lcd.getItemNo(), lcd.getItemOrder());
    	}
    	return itemMap;
    }
    
    /**
     * 获取数组配置值
     * @param classNo
     * @param itemNo
     * @return
     */
    public static synchronized String getItemString(String classNo,String itemNo) {
        try{
        	Libclassd lcd = getLibclassd(classNo,itemNo);
        	if(lcd != null){
        		return lcd.getItemValue();
        	}
        	return StringUtils.EMPTY;
        }catch(Exception ex){
            return null;
        }
    }
    
    public static synchronized String getItemName(String classNo, String itemNo){
    	try{
        	Libclassd lcd = getLibclassd(classNo,itemNo);
        	if(lcd != null){
        		return lcd.getItemName();
        	}
        	return StringUtils.EMPTY;
        }catch(Exception ex){
            return null;
        }
    }
    
    public static synchronized String getItemRemark(String classNo, String itemNo){
    	try{
        	Libclassd lcd = getLibclassd(classNo,itemNo);
        	if(lcd != null){
        		return lcd.getRemark();
        	}
        	return StringUtils.EMPTY;
        }catch(Exception ex){
            return null;
        }
    }
    
    /**
     * 获取数组配置值  没有值获取默认值
     * @param classNo
     * @param itemNo
     * @param defaultValue
     * @return
     */
    public static synchronized String getItemString(String classNo,String itemNo, String defaultValue) {
        String v = getItemString(classNo,itemNo);
        return (v == null) ? defaultValue : v;
    }
    
    /**
     * 获取数组配置值
     * @param classNo
     * @param itemNo
     * @return
     */
    public static synchronized int getItemIntValue(String classNo,String itemNo) {
        return  Integer.parseInt(getItemString(classNo,itemNo));
    }
    
    /**
     * 获取数组配置值  没有值获取默认值
     * @param classNo
     * @param itemNo
     * @param defaultValue
     * @return
     */
    public static int getItemIntValue(String classNo,String itemNo, int defaultValue) {
        String v = getItemString(classNo,itemNo);
        return (v == null) ? defaultValue : Integer.parseInt(v);
    }
    
    /**
     * 获取数组配置值
     * @param classNo
     * @param itemNo
     * @return
     */
    public static float getItemFloatValue(String classNo,String itemNo) {
        return  Float.parseFloat(getItemString(classNo,itemNo));
    }
    
    /**
     * 获取数组配置值，如果配置值为null则用默认值代替
     * @param classNo
     * @param itemNo
     * @param defaultValue 默认的系统常量配置值
     * @return float型的系统常量配置值
     */
    public static float getItemFloatValue(String classNo,String itemNo, float defaultValue) {
        String v = getItemString(classNo,itemNo);
        return (v == null) ? defaultValue : Float.parseFloat(v);
    }
    
    public static boolean getItemBoolean(String classNo,String itemNo) {
    	String v = getItemString(classNo,itemNo);
    	return (v == null) ? false : Boolean.parseBoolean(v);
    }
    
    public static String getProperty(String key){
    	String value = null;
    	InputStream ins = LibFunConfig.class.getClassLoader().getResourceAsStream("config.properties");
		if (ins != null) {
			Properties pro = new Properties();
			try {
				pro.load(ins);
				value = pro.getProperty(key);
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (ins != null)
						ins.close();
				} catch (IOException e) {
					logger.error(e.toString());
					e.printStackTrace();
				}
			}
		}
    	return value;
    }
    
    /**
     * 获取数组名对应的数组map
     * @param classNo
     * @return
     */
    public static Map<String,String> getMapValueName(String classNo){
    	Map<String,String> itemMap = new TreeMap<String,String>();
    	List<Libclassd> lcdList = getLibclassdList(classNo);
    	
    	Collections.sort(lcdList, new ComparatorLibClass());
    	for(Libclassd lcd : lcdList){
    		itemMap.put(lcd.getItemValue(), lcd.getItemName());
    	}
    	return itemMap;
    }
}
