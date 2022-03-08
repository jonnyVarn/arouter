#!/usr/sbin/nft -f

flush ruleset

# Our future selves will thank us for noting what cable goes where and labeling the relevant network interfaces if it isn't already done out-of-the-box.
define WANLINK = eth0 # eth0
define LANLINK = br0 # eth1 wlan0

define PORTFORWARDS = { http, https }

# We never expect to see the following address ranges on the Internet
define BOGONS4 = { 0.0.0.0/8, 10.0.0.0/8, 10.64.0.0/10, 127.0.0.0/8, 127.0.53.53, 169.254.0.0/16, 172.16.0.0/12, 192.0.0.0/24, 192.0.2.0/24, 192.168.0.0/16, 198.18.0.0/15, 198.51.100.0/24, 203.0.113.0/24, 224.0.0.0/4, 240.0.0.0/4, 255.255.255.255/32 }

# The actual firewall starts here
table inet filter {
    # Additional rules for traffic from the Internet
        chain inbound_world {
                # Drop obviously spoofed inbound traffic
                ip saddr { $BOGONS4 } drop
        }
    # Additional rules for traffic from our private network
        chain inbound_private {
                # ssh, incoming DNS traffic, and incoming DHCP traffic
                ip protocol . th dport vmap { tcp . 22 : accept, udp . 53 : accept, tcp . 53 : accept, udp . 67 : accept }
        }
        # Our funnel for inbound traffic from any network
        chain inbound {
                # Default Deny
                type filter hook input priority 0; policy drop;
                # Allow established and related connections: Allows Internet servers to respond to requests from our Internal network
                ct state vmap { established : accept, related : accept, invalid : drop} counter

                # ICMP is - mostly - our friend. Limit incoming pings somewhat but allow necessary information.
                icmp type echo-request counter limit rate 5/second accept
                ip protocol icmp icmp type { destination-unreachable, echo-reply, echo-request, source-quench, time-exceeded } accept
                # Drop obviously spoofed loopback traffic
                iifname "lo" ip daddr != 127.0.0.0/8 drop

                # Separate rules for traffic from Internet and from the internal network
                iifname vmap { lo: accept, $WANLINK : jump inbound_world, $LANLINK : jump inbound_private }
        }
        # Rules for sending traffic from one network interface to another
        chain forward {
                # Default deny, again
                type filter hook forward priority 0; policy drop;
                # Accept established and related traffic
                ct state vmap { established : accept, related : accept, invalid : drop }
                # Let traffic from this router and from the Internal network get out onto the Internet
                iifname { lo, $LANLINK } accept
                # Only allow specific inbound traffic from the Internet (only relevant if we present services to the Internet).
                tcp dport { $PORTFORWARDS } counter
        }
}

# Network address translation: What allows us to glue together a private network with the Internet even though we only have one routable address, as per IPv4 limitations
table ip nat {
        chain  prerouting {
                type nat hook prerouting priority -100;
                # Send specific inbound traffic to our internal web server (only relevant if we present services to the Internet).
                iifname $WANLINK tcp dport { $PORTFORWARDS } dnat to 192.168.100.1
        }
        chain postrouting {
                type nat hook postrouting priority 100; policy accept;
                # Pretend that outbound traffic originates in this router so that Internet servers know where to send responses
                oif $WANLINK masquerade
        }
}
