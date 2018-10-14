#!/bin/bash
#统计shell为/bin/bash的用户的密码存储到/tmp/getuupwd.log中去
sed -n '/\/bin\/bash$/p' /etc/passwd > /tmp/user.tmp
for i in `sed '' /tmp/user.tmp`
do
	let x++
	a[$x]=`echo ${i%%:*}`
	b[$x]=$(grep ${a[$x]} /etc/shadow | awk -F: '{print $2}')
	echo "${a[$x]}-->${b[$x]}" >> /tmp/getuupwd.log
done
for i in `seq $x`
do
	echo "${a[$i]}-->${b[$i]}"
done
