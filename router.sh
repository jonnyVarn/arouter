#! /bin/ash
echo "arouter" >/etc/hostname
apk add iptables acf-iptables dnsmasq acf-dnsmasq openvpn acf-openvpn openrc bridge linux-firmware-cypress
rc-update add swclock boot    # enable the software clock
rc-update del hwclock boot    # disable the hardware clock
setup-acf
