#! /bin/ash
echo "arouter" >/etc/hostname
apk add iptables acf-iptables dnsmasq acf-dnsmasq openvpn acf-openvpn openrc
setup-acf
