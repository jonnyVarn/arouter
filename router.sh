!# /bin/ash
echo "crouter" >/etc/hostname
apk add iptables acf-iptables dnsmasq acf-dnsmasq openvpn afc-openvpn openrc
setup-acf
