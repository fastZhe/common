#!/bin/bash

base=/docker/javatomcat/apache-tomcat-8.0.47

action=$1

function usage(){
	echo "Usage: tomcat.sh [start|status|stop|restart]"
}

function start(){
	${base}/bin/startup.sh
}

function getpid(){
	pid=`ps -ef | grep ${base} | grep -v "grep" |awk '{print $2}'`
	#如果使用return返回  返回值不能大于255
	echo ${pid}
}

function status(){
	pid=`getpid`
	#echo "pid: ${pid}"
	if [ -z $pid ];then
		echo "tomcat is stop"
	else
		echo "tomcat is running"
	fi
}

function stop(){
	${base}/bin/shutdown.sh
}

function restart(){
	start
	stop
}


case $action in
	start)
	start;;
	stop)
	stop;;
	restart)
	restart;;
	status)
	status;;
	*)
	usage;;
esac
	
