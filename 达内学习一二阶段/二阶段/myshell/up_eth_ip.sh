#!/bin/bash
# $1 网卡名
# $2 ip地址加掩码，ip/mask
nmcli connection add con-name $1 ifname eth3 type ethernet
nmcli connection modify $1 ipv4.method manual ipv4.addresses $2 connection.autoconnect yes
nmcli connection up $1
