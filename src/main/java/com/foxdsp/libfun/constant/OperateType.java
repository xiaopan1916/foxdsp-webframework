package com.foxdsp.libfun.constant;

import com.foxdsp.libfun.util.LibFunConfig;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

/**
 * 定义一些操作:【增,删,改,查】
 * @author jinyangyang	
 * @since 2013-12-16 上午11:19:13
 *
 *
 */
public enum OperateType {
	
	INSERT ("insert"),DELETESOME("deleteSome"),UPDATE("update"),QUERY("query");
	
    private  String operate;  
    
	private  OperateType(String operate) { 
        this .operate = operate;
    }
	
	 public String getOperate() {
			return operate;
	}

	public void setOperate(String operate) {
		this.operate = operate;
	}
    
    /**
     * @param args
     */
   public static void main(String[] args ) {
	   
	   //test..
	   
	   getOperate2ServiceMethod("bsdeptService");
	   
	   getOperate2ServiceMethod("bspositionService");
	   
	   getOperate2ServiceMethod("adorderService");
	   
   }
   
   
   
   private static final Map<String, String> defaultOperate2ServiceMethod;
   static {
	   defaultOperate2ServiceMethod = new HashMap<String, String>();
	   OperateType[] operateTypes = OperateType.values();
	   for (OperateType operateType : operateTypes) {
		   	  defaultOperate2ServiceMethod.put(operateType.getOperate(), operateType.getOperate());
	     }
   }
   
   
   private  static final Map<String,Map<String, String>>  serviceOperate2MethondDetailMap;//serviceName->(operate-->methodName)
   static {
	   serviceOperate2MethondDetailMap = new HashMap<String,Map<String, String>>();
		InputStream ins = LibFunConfig.class.getClassLoader().getResourceAsStream("serviceOperateMethodDetail.properties");
		if (ins != null) {
			Properties pro = new Properties();
			try {
				pro.load(ins);
				for(Map.Entry<Object,Object> entry: pro.entrySet()){
					String key = entry.getKey().toString();
					String value = entry.getValue().toString();
					//System.out.println(key+"=>"+value);
					String[] serviceAndOperate = key.split("-");
					if ( serviceAndOperate!=null && serviceAndOperate.length == 2 ) {
						String service = serviceAndOperate[0];
						String operate = serviceAndOperate[1];
						Map<String, String> operate2Methond = serviceOperate2MethondDetailMap.get(service);
						if ( operate2Methond == null ) {
							operate2Methond = new HashMap<String, String>();
							serviceOperate2MethondDetailMap.put(service, operate2Methond);
						}
						operate2Methond.put(operate, value);
					}
				}
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					if (ins != null) {
						ins.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
   }
   
   
   
   /**
     * TODO:下面的代码移植到合适的地方
	 * 获取指定service的增删改查操作对应的methodName
	 * @param serviceName
	 * @return
	 */
	public static Map<String, String> getOperate2ServiceMethod(String serviceName) {
		
		Map<String, String> result = new HashMap<String, String>();
		
		//merge两个map
		
		//1.default map
		for(Map.Entry<String, String> entry: defaultOperate2ServiceMethod.entrySet()) {
			result.put(entry.getKey(), entry.getValue());
		}
		
		//2.custom map
		if ( serviceOperate2MethondDetailMap.containsKey(serviceName) ) {
			Map<String, String> customMap = serviceOperate2MethondDetailMap.get(serviceName);
			for(Map.Entry<String, String> entry: customMap.entrySet()) {
				result.put(entry.getKey(), entry.getValue());
			}
		}
//System.err.println(serviceName);
//System.err.println(result);
		return result;
	}
   
   
}
