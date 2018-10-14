#!/bin/bash
cat /etc/hosts | egrep "^(127)|^(172)"
grep "bash" /etc/passwd
egrep "[0-9]{3,}" /etc/passwd
grep "^server" /etc/chrony.conf
grep "Port" /etc/ssh/sshd_config
egrep "(root)|(adm)" /etc/passwd
grep "Failed"   /var/log/secure
uptime | grep "\."
