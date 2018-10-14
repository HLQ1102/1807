#!/bin/bash
# 这个脚本应该使用source执行
sed -i '53,54s/#//' /etc/security/limits.conf
sed -i '53s/core/nofile/' /etc/security/limits.conf
sed -i '54s/rss/nofile/' /etc/security/limits.conf
sed -i '53s/0$/10000/' /etc/security/limits.conf
ulimit -Hn 10000
ulimit -Sn 10000
