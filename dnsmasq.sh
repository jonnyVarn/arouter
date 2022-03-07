#!/bin/sh

apt install dnsmasq -y
systemctl add dnsmasq

echo "interface=eth1" >/etc/dnsmasq.conf 
echo "except-interface=eth0" >> /etc/dnsmasq.conf
echo "dhcp-range=subnet0,192.168.100.100,192.168.100.200,255.255.255.0,12h" >> /etc/dnsmasq.conf
echo "bind-interfaces" >> /etc/dnsmasq.conf
echo "log-queries" >> /etc/dnsmasq.conf
echo "log-dhcp" >> /etc/dnsmasq.conf
#dhcp-host=aa:bb:cc:dd,192.168.99.99,somehost
