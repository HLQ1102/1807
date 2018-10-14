#!/bin/bash
null=/dev/null
case $1 in 
start)
	/usr/local/nginx/sbin/nginx &> /dev/null
	[ $? -eq 0 ] && echo "你的服务己经正常启动啦"
	[ $? -ne 0 ] && echo "你的服务己经正常启动啦，请不要重复启动哦"
;;
restart)
	/usr/local/nginx/sbin/nginx -s stop &> /dev/null
	/usr/local/nginx/sbin/nginx &> /dev/null
	echo "服务重启成功"
;;
stop)
	/usr/local/nginx/sbin/nginx -s stop &> /dev/null
	[ $? -eq 0 ] && echo "您的服务已经结束"
	[ $? -ne 0 ] && echo '您的服务已经结束了，不要麻烦人家啦！！'
;;
status)
	/usr/local/nginx/sbin/nginx &> /dev/null
	if [ $? -eq 0 ];then
		/usr/local/nginx/sbin/nginx -s stop &> /dev/null
		echo "你的服务未启动"
	else
		echo "你的服务正在运行"
	fi
esac
