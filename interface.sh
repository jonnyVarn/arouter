!# /bin/ash
echo "auto eth0" > /etc/network/interfaces 
echo "iface eth0 inet dhcp" >> /etc/network/interfaces
echo "auto eth1" >> /etc/network/interfaces
echo "iface eth1 inet static" >> /etc/network/interfaces
echo "address 192.168.100.1 " >> /etc/network/interfaces
echo "netmask 255.255.255.0" >> /etc/network/interfaces
