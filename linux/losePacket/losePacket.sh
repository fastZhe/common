#!/usr/bin/env bash
#set -x
basepath=$(cd `dirname $0`;pwd)

baselevel=100
ips=$1
if [  -z "$ips" ];then
	echo [use $0 ipfile or $0 ipfile [50]] ;
	exit 1
fi
if [ ! -z "$2" ];then
	baselevel=$2
fi
echo   >./failture_ip.txt
echo   >./success_ip.txt

#for ip in `cat $basepath/$ips`
while read ip
do
	echo $ip
	echo "cmd : ping -c 200 -i 0 $ip | grep 'packet loss' | awk -F \",\" '{print }' | awk '{print $1}' "
	rate=`ping -c 200 -i 0 $ip | grep 'packet loss' | awk -F "," '{print  $(NF-1)}' | awk '{print $1}'`
	rate=${rate%\%*}
	echo $rate

	if [ "$rate" -ge "$baselevel" ];then
		echo $ip lose packet $rate%
		echo  "$ip\n" >>./failture_ip.txt
	else
		echo  "$ip\n" >>./success_ip.txt
	fi
done < $basepath/$ips
