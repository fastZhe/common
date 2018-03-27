#!/usr/bin/env bash
#set -x
.  ./log.sh

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


############################################################
##########ping tools       #################################
############################################################

function pingFun(){
    file=$1
    while read ip
        do
           log info  $ip
           log info  "cmd : ping -c 100 -i 0 $ip | grep 'packet loss' | awk -F \",\" '{print }' | awk '{print $1}' "
           rate=`ping -c 100 -i 0 $ip | grep 'packet loss' | awk -F "," '{print  $(NF-1)}' | awk '{print $1}'`
           rate=${rate%\%*}
           log info  $rate
           
           if [ "$rate" -ge "$baselevel" ];then
           	log error "$ip lose packet $rate%"
           	echo  "$ip\n" >>./failture_ip.txt
           else
           	echo  "$ip\n" >>./success_ip.txt
           fi
    done < $file
}

# start ping .......

pingFun $basepath/$ips
