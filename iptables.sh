#!/bin/bash
iptables -t nat -N PROXY
iptables -t nat -F PROXY
iptables -t nat -A PROXY -d 192.168.0.0/16 -j ACCEPT
iptables -t nat -A PROXY -d 172.16.0.0/12 -j ACCEPT
iptables -t nat -A PROXY -d 10.0.0.0/8 -j ACCEPT 
iptables -t nat -A PROXY -s 172.16.0.0/12  -p tcp --dport 80 -j REDIRECT --to-port 3128
#iptables -t nat -A PREROUTING -p tcp -s 192.168.201.0/24 --dport 80 -j DNAT --to 192.168.201.250:3128
#iptables -t nat -A PREROUTING -p tcp -s 192.168.201.0/24 --dport 443 -j DNAT --to 192.168.201.250:3129
iptables -t nat -A PREROUTING -j PROXY
