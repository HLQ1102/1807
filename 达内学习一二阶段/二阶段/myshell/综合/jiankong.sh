#!/bin/bash
while :
do
clear
CPUR=`uptime | awk '{print $NF}'`
echo "你的服务器最近15分钟的负载是：$CUPR"
RX=`ifconfig eth0 | awk '/RX p/{print $5}'`
TX=`ifconfig eth0 | awk '/TX p/{print $5}'`
echo -e "我的入站流量是：${RX}\n我的出站流量是：${TX}"
free=`free | awk '/^Mem/{print $4}'`
echo "我的剩余内存是：$free"
GEN=`df -h | awk '/\/$/{print $4}'`
echo "根分区剩余容量是：$GEN"
who=`who | wc -l`
echo "当前登陆我的服务器的人数：$who"
rp=`rpm -qa | wc -l`
echo "已安装的软件的数量是：$rp"
sleep 0.7
done
