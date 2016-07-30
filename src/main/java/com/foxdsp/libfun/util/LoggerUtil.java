package com.foxdsp.libfun.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 * debug信息输出到一个独立的文件
 * Created by jinyangyang on 1/22/16 10:43 AM.
 */
public class LoggerUtil {

    private LoggerUtil() {
    }

    private static final Logger DEBUGLOGGER = LogManager.getLogger("forDebug");

    private static final Logger ERRORLOGGER = LogManager.getLogger("forError");

    public static void debug( String msg ,Object... params) {
        if ( DEBUGLOGGER.isDebugEnabled() ) {
            DEBUGLOGGER.debug(msg,params);
        }
    }

    public static void info( String msg ,Object... params) {
        if ( DEBUGLOGGER.isInfoEnabled() ) {
            DEBUGLOGGER.info(msg,params);
        }
    }

    public static void warn( String msg ,Object... params) {
        if ( DEBUGLOGGER.isWarnEnabled() ) {
            DEBUGLOGGER.warn(msg,params);
        }
    }

    public static void error( String msg,Object... params) {
        if ( ERRORLOGGER.isErrorEnabled() ) {
            ERRORLOGGER.error(msg,params);
        }
    }
}
