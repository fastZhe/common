#!/usr/bin/env bash

if [ -z "$1" ];then
  echo use $0 hostname
  exit 1
fi
host=$1


base=$(cd `dirname $0`;pwd)


which wget
is=`echo $?`
if [ "$is" != "0" ];then
yum install wget -y
fi

#yum
cd /etc/yum.repos.d
mkdir back
mv *.repo back
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo

#修改selinux
sed -i 's;^SELINUX=.*;SELINUX=disabled;g' /etc/sysconfig/network


#修改主机名
sed -i 's;^HOSTNAME=.*;HOSTNAME=$host;g' /etc/selinux/config
hostname $host



#初始化ssh
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa


echo "将在6s后重启"
sleep 6s
init 6