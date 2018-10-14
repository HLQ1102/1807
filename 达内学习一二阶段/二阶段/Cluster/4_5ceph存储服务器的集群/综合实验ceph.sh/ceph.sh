#!/bin/bash
#node1

#无密码登陆,及yum的签名验证
sed -i '/gpgcheck=1/c gpgcheck=0' /etc/yum.conf
ssh-keygen -f /root/.ssh/id_rsa -N ‘’
for i in 0 1 2 3
do
ssh-copy-id node$i
scp /etc/yum.conf node$i:/etc
done

#安装部署软件ceph-deploy
yum -y install ceph-deploy.noarch
mkdir /root/ceph-cluster
cd ceph-cluster

#创建Ceph集群
ceph-deploy new node1 node2 node3
ceph-deploy install node1 node2 node3
ceph-deploy mon create-initial

#划分日志盘,node1,node2,node3都要做
for i in 1 2 3
do
ssh node$i parted /dev/vdb mktable gpt
ssh node$i parted /dev/vdb mkpart primary 1M 50%
ssh node$i parted /dev/vdb mkpart primary 50% 100%
ssh node$i chown ceph.ceph /dev/vdb1
ssh node$i chown ceph.ceph /dev/vdb2
done
#使权限永久生效
for i in 1 2 3
do
ssh node$i chmod +x /etc/rc.d/rc.local
ssh node$i echo 'chown ceph:ceph /dev/vdb*' >> /etc/rc.d/rc.local
done
#初始化清空磁盘数据
for i in 1 2 3
do
ceph-deploy disk zap node$i:vdc node$i:vdd
done

#创建OSD存储设备（仅在node51上进行管理操作）,并指定日志磁盘
for i in 1 2 3 
do
ceph-deploy osd create node$i:vdc:/dev/vdb1 node$i:vdd:/dev/vdb2
done

#时间同步服务器clinet0
cp /etc/chrony.conf /tmp
sed -i '3,5d' /tmp/chrony.conf
sed -i '3a allow 192.168.4.0/24' /tmp/chrony.conf
ssh /tmp/chrony.conf client0:/etc/
ssh client0 systemctl restart chronyd

#同步时间，node1-3
sed -i '3,6d' /etc/chrony.conf
sed -i '2a server 192.168.4.10 iburst' /etc/chrony.conf
for i in 1 2 3
do
scp /etc/chrony.conf node$i:/etc/
ssh node$i systemctl restart chronyd
done

#重启所有的ceph服务,非必须
systemctl restart ceph\*.service ceph\*.target
#node51、node52、node53这些服务应该都是正常运行的
ceph -s




