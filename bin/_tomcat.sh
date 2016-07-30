#!/bin/bash
basepath=$(cd "$(dirname "$0")"; pwd);
cd $basepath/../;
projectDir=`pwd`

tomcatDir=`find ${projectDir} -name catalina.sh | sed 's#/catalina.sh##'`

function shutdownTomcat()
{
        delay=$1;
        ${tomcatDir}/shutdown.sh;
        sleep $delay;
        tomcat=`ps aux | grep tomcat | grep -v grep  | awk '{print $2}'`
        echo $tomcat
        if [[  ! -z $tomcat ]]; then
            echo "tomcat still exist ! will use kill -9 .."
            kill -9 $tomcat
        fi
        tomcat=`ps aux | grep tomcat | grep -v grep  | awk '{print $2}'`
        echo $tomcat
}

function startTomcat() {
       ${tomcatDir}/startup.sh;
}