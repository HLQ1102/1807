#!/bin/bash
mkdir -p /home/user/ &> /dev/null
for i in `cat /etc/passwd`
do
    echo ${i%%:*} >> /home/user/user.txt
    echo $?
done
