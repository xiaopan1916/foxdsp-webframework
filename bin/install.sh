#!/bin/bash
# Program:
#    快速搭建和部署 webadmin  环境
# History:
#    2016/02/17 Hongbin.Yuan First release

####################################################
########## source用户的环境变量,加入crontab过后，
########## 由于环境变量的问题，mysql将不能插入数据库
. /etc/profile
. ~/.bash_profile
###################################################
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:${PATH}
export PATH
cd ~

ad_config_file="/usr/local/htdocs/ad-config-files"
local_ip=$(ifconfig eth0 | sed -n "2,2p" | awk '{print $2}')

if [ $# == 0 ] ; then
        echo "please enter env. USAGE: $0 [test | product] "
        echo " e.g.: $0 test ;"
        echo " e.g.: $0 product ;"
        exit 1;
fi

#### 增量插入文本， 调用必须传入两个参数，第一个 是  修改的文件，第二个是插入的行内容
function addToFile {
 if grep -i "$2" $1
 then
    echo "$2 already added fo file $1."
 else
    echo "add content $2 to file $1 "
    echo $2  >> $1
 fi
}

## 配置 rsync 服务

echo "
# /etc/rsyncd: configuration file for rsync daemon mode

# See rsyncd.conf man page for more options.

# configuration example:

# uid = nobody
# gid = nobody
# use chroot = yes
# max connections = 4
# pid file = /var/run/rsyncd.pid
# exclude = lost+found/
# transfer logging = yes
# timeout = 900
# ignore nonreadable = yes
# dont compress   = *.gz *.tgz *.zip *.z *.Z *.rpm *.deb *.bz2

# [ftp]
#        path = /home/ftp
#        comment = ftp export area

pid file = /var/run/rsyncd.pid
port = 873
address = $local_ip
uid = root
gid = root
use chroot = yes
read only = yes
hosts allow=$local_ip/255.255.255.0
hosts deny=*
max connections = 15
log format = %t %a %m %f %b
syslog facility = local3
timeout = 300
[samba_data]
path =  $ad_config_file
list=no
ignore errors
auth users = root
secrets file = /etc/rsyncd.secrets
users = root
" > /etc/rsyncd.conf

echo "root:111111" > /etc/rsyncd.secrets
chmod 600 /etc/rsyncd.secrets


##开机启动 rsync
startRsync="rm -rf /var/run/rsyncd.pid && /usr/bin/rsync --daemon --config=/etc/rsyncd.conf"
addToFile /etc/rc.d/rc.local "$startRsync"
chmod +x /etc/rc.d/rc.local

##创建日志目录
mkdir -p /data1/tmp/admin_log/

#function installNtpdate()
#{
#	crontab -l | grep ntp1.aliyun.com -q
#	ret=$?
#	if [[  $ret -ne 0 ]]; then
#		echo "add ntpdate support!"
#		cronfile=/tmp/crontab_`whoami`
#		crontab -l > $cronfile
#		/bin/systemctl stop ntpd.service
#		echo "* * * * * /usr/sbin/ntpdate pool.ntp.org >> /tmp/ntp.log" >> $cronfile
#		echo "* * * * * /usr/sbin/ntpdate ntp1.aliyun.com >> /tmp/ntp1.log" >> $cronfile
#		crontab $cronfile
#		rm -rf $cronfile
#	fi
#	#https://help.aliyun.com/knowledge_detail/6713325.html?pos=1#ECS
#	#tinker panic 0
#	grep -q "tinker panic 0" /etc/ntp.conf ||  sed -e "1a tinker panic 0" -i /etc/ntp.conf
#	/bin/systemctl stop ntpd.service
#}
#
#installNtpdate



