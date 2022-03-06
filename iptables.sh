#!/bin/ash

apk add iptables
rc-update add iptables

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth1 -j ACCEPT
/etc/init.d/iptables save
/etc/init.d/iptables restart
