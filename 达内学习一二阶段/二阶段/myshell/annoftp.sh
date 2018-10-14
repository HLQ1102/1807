#!/bin/bash
yum -y install vsftpd
sed -i -r 's/#an/an/' /etc/vsftpd/vsftpd.conf
setenforce 0
chmod 1757 /var/ftp/pub/
systemctl restart vsftpd
systemctl enable vsftpd
