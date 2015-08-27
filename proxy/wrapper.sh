#!/bin/bash
iptables=/sbin/iptables

cleanRules() {
    $iptables -D PREROUTING -j PROXY -t nat
    $iptables -t nat -F PROXY
    $iptables -t nat -X PROXY
}

trap 'cleanRules' SIGTERM

cleanRules
$iptables -t nat -N PROXY
$iptables -t nat -A PROXY -d 192.168.0.0/16 -j ACCEPT
$iptables -t nat -A PROXY -d 172.16.0.0/12 -j ACCEPT
$iptables -t nat -A PROXY -d 10.0.0.0/8 -j ACCEPT
$iptables -t nat -A PROXY -s 172.16.0.0/12  -p tcp --dport 80 -j REDIRECT --to-port 3128
$iptables -t nat -A PROXY -s 172.16.0.0/12  -p tcp --dport 443 -j REDIRECT --to-port 3129
$iptables -t nat -A PREROUTING -j PROXY

ln -s /usr/lib/squid3/ssl_crtd /bin/ssl_crtd

/usr/sbin/squid3 -z

# Initialize ssldb
/bin/ssl_crtd -c -s /var/spool/squid3_ssldb

/usr/sbin/squid3 -NCd1
