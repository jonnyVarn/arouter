#! /bin/sh
apt install hostapd -y
echo "interface=wlan0" >/etc/hostapd.conf
echo "bridge=br0" >>/etc/hostapd.conf
echo "hw_mode=n" >>/etc/hostapd.conf
echo "channel=1" >>/etc/hostapd.conf
echo "wmm_enabled=0" >>/etc/hostapd.conf
echo "macaddr_acl=0" >>/etc/hostapd.conf
echo "auth_algs=1" >>/etc/hostapd.conf
echo "ignore_broadcast_ssid=0" >>/etc/hostapd.conf
echo "wpa=2" >>/etc/hostapd.conf
echo "wpa_key_mgmt=WPA-PSK" >>/etc/hostapd.conf
echo "wpa_pairwise=TKIP" >>/etc/hostapd.conf
echo "rsn_pairwise=CCMP" >>/etc/hostapd.conf
echo "ssid=arouter" >>/etc/hostapd.conf
echo "wpa_passphrase=password" >>/etc/hostapd.conf



