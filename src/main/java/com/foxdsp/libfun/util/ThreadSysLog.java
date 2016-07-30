package com.foxdsp.libfun.util;

import com.foxdsp.libfun.model.Syslog;
import org.apache.log4j.Logger;

import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;

/**
 * 操作日志入库处理
 */
public class ThreadSysLog {

	private static Logger log = Logger.getLogger(ThreadSysLog.class);

	/**
	 * 此队列按照 FIFO（先进先出）原则对元素进行排序
	 */
	private static Queue<Syslog> queue = new ConcurrentLinkedQueue<Syslog>();


	/**
	 * 向队列中增加Syslog对象，基于ConcurrentLinkedQueue
	 * @param syslog
	 */
	public static void add(Syslog syslog){
		// 将指定元素插入此队列的尾部
		queue.offer(syslog);
	}
	
	/**
	 * 获取Syslog对象，基于ConcurrentLinkedQueue
	 * @return
	 */
	private static Syslog getSyslog(){
		// 获取并移除此队列的头，如果此队列为空，则返回 null
      	return queue.poll();

	}
	
	/**
	 * 启动入库线程
	 */
	public static void startSaveDBThread() {
		try {
			for (int i = 0; i < 10; i++) {
				Thread insertDbThread = new Thread(new Runnable() {
					public void run() {
						while (true) {
							try {
								// 取队列数据
								Syslog sysLog = getSyslog();
								if(null == sysLog){
									Thread.sleep(200);
								} else {
									sysLog.save();
								}
							} catch (Exception e) {
								log.error("保存操作日志到数据库异常：" + e.getMessage());
								e.printStackTrace();
							}
							
						}
						
					}
				});
				insertDbThread.start();
			}
		} catch (Exception e) {
			throw new RuntimeException("ThreadSysLog new Thread Exception");
		}
	}
	
}
