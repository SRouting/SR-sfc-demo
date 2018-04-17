#!/bin/bash

#interfaces configuration
ifconfig eth1 up
ip -6 addr add fc00:45::5/64 dev eth1

ifconfig eth2 up
ip -6 addr add fc00:56::5/64 dev eth2

# Enable forwarding
sysctl -w net.ipv6.conf.all.forwarding=1

# Accept SRv6 traffic
sysctl -w net.ipv6.conf.all.seg6_enabled=1
sysctl -w net.ipv6.conf.lo.seg6_enabled=1
sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sysctl -w net.ipv6.conf.eth2.seg6_enabled=1


# Configure VNFs
cd ~/
rm -rf sr-sfc-demo/
git clone https://github.com/SRouting/sr-sfc-demo
cd sr-sfc-demo/config/
sh deploy-vnf.sh add f3 veth0 veth1 fd00:5:0::f3:1/64 fd00:5:1::f3:1/64 fd00:5:0::f3:2/64 fd00:5:1::f3:2/64
ip netns exec f3 sysctl -w net.ipv6.conf.all.seg6_enabled=1
ip netns exec f3 sysctl -w net.ipv6.conf.lo.seg6_enabled=1
ip netns exec f3 sysctl -w net.ipv6.conf.veth0-f3.seg6_enabled=1
ip netns exec f3 sysctl -w net.ipv6.conf.veth1-f3.seg6_enabled=1
ip netns exec f3 ifconfig lo up
ip netns exec f3 ip -6 route add local fc00:5::f3:0/112 dev lo

# Configure Routing
ip -6 route add fc00:6::/64 via fc00:56::6
ip -6 route add fc00:1::/64 via fc00:45::4
ip -6 route add fc00:5::f3:0/112 via fd00:5:0::f3:2

# configure snort rules
sudo mkdir -p /etc/snort/ /etc/snort/rules/ /var/log/snort
touch /etc/snort/snort.conf /etc/snort/rules/local.rule
echo 'var RULE_PATH rules' >> /etc/snort/snort.conf
echo 'include $RULE_PATH/local.rule' >> /etc/snort/snort.conf
echo 'alert icmp any any -> any any (msg:"ICMP detected"; sid:1000)' >> /etc/snort/rules/local.rule
