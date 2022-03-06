#!/bin/ash

apk add iptables
rc-update add iptables

echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

iptables -t nat -A POSTROUTING -o $WAN -j MASQUERADE
iptables -A FORWARD -i $LAN -j ACCEPT
/etc/init.d/iptables save
/etc/init.d/iptables restart
