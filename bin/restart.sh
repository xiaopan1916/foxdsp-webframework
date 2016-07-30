#!/bin/bash
basepath=$(cd "$(dirname "$0")"; pwd);
. ${basepath}/_tomcat.sh
echo "Restarting ..."
shutdownTomcat 5
startTomcat
echo "Restarting over.."

#case "$1" in
#    start)
#        echo "Starting ..."
#        startTomcat
#        echo "started..."
#        ;;
#    stop|shutdown)
#        echo "Stopping ..."
#        shutdownTomcat  6
#        echo "stopped..."
#        ;;
#    restart)
#        echo "Restarting ..."
#        shutdownTomcat 5
#        startTomcat
#        echo "Restarting over.."
#        ;;
#    *)
#        echo "Usage: restartTomcat.sh {start|stop(shutdown)|restart}" >&2
#        exit 3
#        ;;
#esac

