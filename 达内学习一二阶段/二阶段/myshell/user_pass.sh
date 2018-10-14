#!/bin/bash
#提取用户名
A=`sed -n '/bash$/s/:.*//p' /etc/passwd`

#提取密码
#    提取密码行
#a=`grep root /etc/shadow`
#    去用户名
#b=`echo ${a#root:}`
#    提取密码
#c=`echo ${b%%:*}`

for i in $A
do
    a=`grep $i /etc/shadow`
    b=`echo ${a#$i:}`
    c=`echo ${b%%:*}`
    echo "用户${i}的密码为：$c"
done

