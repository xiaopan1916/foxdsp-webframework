/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.foxdsp.libfun.web;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

/**
 *
 * @author IceRao
 */
public class WebApplicationContextUtil {
    //在web进行初始化时，将Spring的上下文设置在此
    public static ApplicationContext webApplicationContext = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
}
