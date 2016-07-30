#/bin/bash
#########################################
#Function:    auto deploy
#Usage:       bash update.sh [profile] [tagname]
#Company:     fox dsp
#Version:     2.0

#examples:
#             update.sh product v0.2
#########################################
#init ??
#init repository
#cd /usr/local/foxdsp/
#git clone git@203.195.159.129:/mnt/gitprojects/rtb/webadmin.git/
#cd webadmin && mvn clean package -Pproduct -DskipTests=true

if [ $# -ne 2 ] ; then
    echo "usage: update.sh profilename branch|tag"
    exit 1
fi

basepath=$(cd "$(dirname "$0")"; pwd);
cd $basepath/../;
projectDir=`pwd`
if [ ! -d  release ]; then
    mkdir release
fi
function movesh()
{
  mkdir -p release/sh 2>/dev/null
  shfiles=`find target -name *.sh`
  for shfile in $shfiles
  do
      #echo $shfile
      cp $shfile release/sh/
      chmod +x release/sh/*.sh
  done
}

c=$2
function checkResult()
{
	check=1
	results=$(git ls-remote | egrep "feature|release|hotfix|develop|master" | awk '{print $2}' | sed "s#refs/heads/##g")
	for result in ${results}; do
		if [[ $result == $c ]]; then
			check=0
			break
		fi
	done
	echo $check
}

function installNtpdate()
{
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
	#https://help.aliyun.com/knowledge_detail/6713325.html?pos=1#ECS
	#tinker panic 0
	grep -q "tinker panic 0" /etc/ntp.conf ||  sed -e "1a tinker panic 0" -i /etc/ntp.conf
	/usr/bin/cp -f ${projectDir}/release/sh/ntp_crontab.sh /etc/cron.d/ntp_crontab
    chmod 644 /etc/cron.d/ntp_crontab
    /bin/systemctl stop ntpd.service
}

git pull
git pull --tags
profile=$1
tag=$2
#检查tag是否存在
valid=`git tag -l $tag`
if [ ! $valid ]; then
    #echo "invalid tagname.."
    #exit 1
    ret=`checkResult`
    #echo "ret:"$ret
    if [ "$ret" != 0 ]; then
        echo "invalid name.."
        exit 1
    fi
fi
action="git checkout $tag"
echo $action
echo $profile
$action
git pull
rm -rf target
mvn clean package -P${profile} -DskipTests=true
warname=`ls target/*.war 2>/dev/null`
jarname=`ls target/*dependencies.jar 2>/dev/null`

#解决重命名java类启动spring会报错
rm -rf ${projectDir}/src/main/webapp/WEB-INF/classes 2>/dev/null

#编译成功,再删除
if test -z "$warname" && test -z "$jarname"
then
    echo "**************build failure****************"
    rm -rf target
    exit 1
elif test -z "$warname"
then
    #j2se project: lib
    echo "going to build j2se project..."
    rm -rf ${projectDir}/release
    cp $jarname ${projectDir}/release
    cp -r target/classes ${projectDir}/release
else
    #web project : war
    echo "going to build web project..."
    rm -rf ${projectDir}/release
    unzip -qo ${warname} -d ${projectDir}/release/
fi
movesh

#move crontab file
## 放入 crontab 文件
/usr/bin/cp -f ${projectDir}/release/sh/crontab_sh.sh /etc/cron.d/webadmin_crontab
chmod 644 /etc/cron.d/webadmin_crontab

rm -rf target
installNtpdate
echo 'update over'
exit 0
