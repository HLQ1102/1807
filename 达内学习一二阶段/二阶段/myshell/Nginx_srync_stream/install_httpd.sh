#!/bin/bash
rpm -q httpd &>/dev/null
[ $? -eq 0 ] && echo "httpd已经安装" && exit
echo "httpd 正在安装....."
yum -y install httpd &> /dev/null
echo "httpd 安装完成....."
