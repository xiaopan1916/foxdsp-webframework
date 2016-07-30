#ntp crontab begin
* * * * * /usr/sbin/ntpdate pool.ntp.org >> /tmp/ntp.log
* * * * * /usr/sbin/ntpdate ntp1.aliyun.com >> /tmp/ntp1.log

#ntp crontab end