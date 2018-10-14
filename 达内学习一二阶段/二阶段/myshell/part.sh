#!/bin/bash
#yum -y install expect &>/dev/null
#[ $? -ne 0 ] && exit 
#for i in {1..3}
#do
expect << EOF
spawn fdisk /dev/vdb
expect "m"               {send "n\n"}
expect "type"            {send "\n"}
expect "默认"             {send "\n"}
expect "扇区"   {send "\n"}
expect "Last"            {send "+1G\n"}
expect "："              {send "w\n"}
expect "："              {send "w\n"}
expect "："              {send "exit\n"}
EOF
for i in 1
do
mkfs.ext4 /dev/vdb$i
mkdir /mnt/vdb$i
echo "/dev/vdb$i /mnt/vdb$i ext4 defaults 0 0" >> /etc/fstab
mount -a
done
#done
