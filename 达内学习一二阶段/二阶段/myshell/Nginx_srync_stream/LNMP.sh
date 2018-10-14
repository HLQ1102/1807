#!/bin/bash
# 前提是准备lnmp_soft.tar.gz包
yum-config-manager --add-repo http://$1/rhel7
sed -i '/gpgcheck=1/c gpgcheck=0' /etc/yum.conf
tar -xf lnmp_soft.tar.gz 
cd lnmp_soft/
tar -xf nginx-1.12.2.tar.gz 
cd nginx-1.12.2/
useradd -s /sbin/nologin nginx
yum -y install gcc pcre-devel openssl-devel
./configure --prefix=/usr/local/nginx --user=nginx --group=nginx --with-http_ssl_module --with-stream --with-http_stub_status_module
make
make install 
cd ..
tar -xf php_scripts/php-memcached-demo.tar.gz
cp -r php-memcached-demo/* /usr/local/nginx/html/
yum -y install mariadb-server mariadb-devel  php-fpm-5.4.16-42.el7.x86_64.rpm php-pecl-memcache.x86_64  memcached
systemctl stop httpd
systemctl restart mariadb php-fpm memcached
systemctl enable mariadb php-fpm
sed -i '65,71s/#//' /usr/local/nginx/conf/nginx.conf
sed -i '69d' /usr/local/nginx/conf/nginx.conf
sed -i '69s/fastcgi_params/fastcgi.conf/' /usr/local/nginx/conf/nginx.conf
/usr/local/nginx/sbin/nginx
ln -s /usr/local/nginx/sbin/nginx /sbin/
 echo '<?php
$i=11;
echo $i;
?>
' > /usr/local/nginx/html/test.php

