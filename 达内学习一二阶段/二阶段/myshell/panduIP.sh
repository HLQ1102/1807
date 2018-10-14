#!/bin/bash
setIP(){
nmcli connection modify $1 ipv4.method manual ipv4.addresses 192.168.4.101/24 connection.autoconnect yes
ifconfig $1 | egrep "inet {1,}[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
[ $? -eq 0 ] && echo "该网卡已经有 IP 地址" && exit
setIP $1
