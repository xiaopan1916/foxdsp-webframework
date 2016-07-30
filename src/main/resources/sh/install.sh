#!/bin/bash

# {env.prjectDir}  由maven 编译而来的地址
CLASSPATH=$CLASSPATH:${env.prjectDir}/WEB-INF/classes:${env.prjectDir}/WEB-INF/lib/*:.
CLASSPATH=$CLASSPATH:${env.tomcatDir}lib/*
export CLASSPATH

LANG=en_US.UTF-8
export LANG

/usr/bin/java  com.foxdsp.libfun.Install $@