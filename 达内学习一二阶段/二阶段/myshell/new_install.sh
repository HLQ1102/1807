#!/bin/bash
x='abcdefghijklmnopqrstuvwxyxABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
mi=''
user=tomcat
for i in {1..8}
do
    s=$[RANDOM%${#x}+1]
    tmp=`echo $x | cut -b $s`
    mi=${mi}$tmp
done

rpm -q vsftpd &> /dev/null
if [ $? -ne 0 ];then
   yum -y install vsftpd &> /dev/null
   if [ $? -eq 0 ];then
        echo "ftp安装成功"
   else
	echo "ftp安装失败"
   fi
else
   echo "ftp已经安装"
fi

systemctl restart vsftpd &> /dev/null
if [ $? -ne 0 ];then
    echo "ftp启动失败"
else
    echo "ftp启动成功"
fi

systemctl enable vsftpd &> /dev/null
if [ $? -ne 0 ];then
    echo "ftp设置开机自动启动失败"
else
    echo "ftp设置开机自动启动成功"
fi

id $user &> /dev/null
if [ $? -ne 0 ];then
    useradd $user &> /null
else
    echo "用户${user}已经存在"
fi

echo $mi | passwd --stdin $user &> /dev/null
if [ $? -eq 0 ];then
   echo "密码修改成功"
else
   echo "密码修改失败"
fi
echo "hello" > /home/tomcat/test.txt
echo "tomcat的密码是:$mi" | mail -s "新建用户$user" root
