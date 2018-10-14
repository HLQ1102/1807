#!/bin/bash
#node1、node2、node3、client0已准备就绪ip如下
#node1:192.168.4.11 
#node2:192.168.4.12
#node3:192.168.4.13
#真机上执行,真机ip:192.168.4.254/24
#rhcs2.0-rhosp9-20161113-x86_64.iso 应该具备，放到/iso下
#rhel-server-7.4-x86_64-dvd.iso    放到/iso下
#有192.168.4.254_rhel7.repo ceph.repo 这两个文件放/root/下
#真机已具有ssh密钥和公钥
yum -y install vsftpd httpd
systemctl restart vsftpd httpd
systemctl enable vsftpd httpd
if [ -e /var/ftp ];then
    mkdir /var/ftp/ceph
fi
if [ -e /var/www/hmtl ];then
    mkdir /var/www/html/rhel7
fi
#为永久开机挂载,可将该命名放至/etc/rc.d/rc.local并赋予它执行权限
mount /iso/rhcs2.0-rhosp9-20161113-x86_64.iso /var/ftp/ceph
mount /iso/rhel-server-7.4-x86_64-dvd.iso /var/www/html/rhel7
#设置真机无密登陆4台虚拟机,需要手动操作
for i in 0 1 2 3 
do
ssh-copy-id 192.168.4.1$i
done
#hosts文件准备
echo '192.168.4.11 node1
192.168.4.12 node2
192.168.4.13 node3
192.168.4.10 client0' > /root/hosts
for i in 0 1 2 3
do
scp /root/hosts 192.168.4.1$i:/etc/
scp /root/192.168.4.254_rhel7.repo 192.168.4.1$i:/etc/yum.repos.d/
scp /root/ceph.repo 192.168.4.1$i:/etc/yum.repos.d/
done
rm -rf /root/hosts
