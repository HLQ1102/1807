#!/bin/bash
yum -y install ftp &> /dev/null
[ $? -ne 0 ] && echo "ftp已经安装"
expect << EOF
spawn ftp 192.168.4.7
expect "Name"      {send "tomcat\n"}
expect "Password:" {send "mrT4xHeB\n"}
expect "ftp>"      {send "get test.txt\n"}
expect ">"         {send "exit\n"}
expect ">"         {send "exit\n"}
EOF
