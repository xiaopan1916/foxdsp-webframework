#!/bin/bash

basepath=$(cd "$(dirname "$0")"; pwd);
. ${basepath}/_tomcat.sh
shutdownTomcat  6
