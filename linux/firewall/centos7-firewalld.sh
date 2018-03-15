#!/usr/bin/env bash

function add(){
echo 开放端口${1} 
firewall-cmd --permanent --zone=public --add-port=${1}/tcp 
firewall-cmd --permanent --zone=public --add-port=${1}/udp 
firewall-cmd --reload
}

function del(){
echo 关闭端口${1}
firewall-cmd --zone=public --remove-port=${1}/tcp --permanent
firewall-cmd --zone=public --remove-port=${1}/udp --permanent
firewall-cmd --reload
}

action=$1
port=$2

if [ -z "${action}" ];then
	echo "use : $0 [add|del] [port];"
	exit 1
fi
if [ -z "${port}" ];then
         echo "use : $0 [add|del] [port];"
	exit 1
fi

case $action in 
	add)
	add ${port};;
	del)
	del ${port};;
	*) 
	echo "use : $0 [add|del] [port];";;
esac
