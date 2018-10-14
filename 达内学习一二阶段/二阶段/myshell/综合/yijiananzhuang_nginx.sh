#!/bin/bash
null=/dev/null
flge=0
a=`yum repolist | awk '/repolist/{print $2}' | sed 's/,//g'`
[ $a -eq 0 ] && echo "未有可用yum，软件部署推出" && exit 
yum -y install gcc openssl-devel pcre-devel &> $null
for i in gcc openssl-devel pcre-devel
do
  rpm -q $i &> $null
  if [ $? -ne 0 ];then
      echo "${i}安装失败，请检查yum"
      flge=1
  fi
done
[ $flge -eq 1 ] && exit 1
cd /root/xiao/nginx-1.12.2
./configureb  --prefix=/usr/local/nginx
make 
make install 
