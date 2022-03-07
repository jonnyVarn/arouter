#! /bin/ash
#brctl addbr br0
echo "auto eth0" > /etc/network/interfaces 
echo "iface eth0 inet dhcp" >> /etc/network/interfaces
echo "auto eth1" >> /etc/network/interfaces
echo "iface eth1 inet static" >> /etc/network/interfaces
echo "auto wlan0" >> /etc/network/interfaces
echo "iface wlan0 inet static" >> /etc/network/interfaces
echo "auto br0" >> /etc/network/interfaces
echo "iface br0 inet static" >> /etc/network/interfaces
echo "    bridge-ports eth1 wlan0" >> /etc/network/interfaces
echo "    address 192.168.100.1" >> /etc/network/interfaces
echo "    broadcaset 192.168.100.255" >> /etc/network/interfaces
echo "    netmask 255.255.255.0" >> /etc/network/interfaces
