#!/bin/bash
x='abcdefghijklmnopqrstuvwxyxABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
for j in {1..20}
do
    mi[$j]=""
    for i in {1..4}
    do
        s=$[RANDOM%${#x}+1]
        tmp=`echo $x | cut -b $s`
        mi[$j]=${mi[$j]}$tmp
    done
done
mkdir /mytouch &> /dev/null
rm -rf /mytouch/* 
for i in {1..20}
do
    touch /mytouch/${mi[$i]} &> /dev/null
    if [ $? -eq 0 ];then
        echo "文件${mi[$i]}创建成功"
    else
	echo "文件${mi[$i]}创建失败"
    fi
done
for i in {1..20}
do
    mv /mytouch/${mi[$i]} /mytouch/${mi[$i]}.jpg
    if [ $? -eq 0 ];then
        echo "${mi[$i]}成功改名为${mi[$i]}.jpg"
    else
	echo "${mi[$i]}改名失败"
    fi
done
