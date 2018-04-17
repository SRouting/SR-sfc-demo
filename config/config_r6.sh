#!/bin/bash

#interfaces configuration
ifconfig eth1 up
ip -6 addr add fc00:36::6/64 dev eth1

ifconfig eth2 up
ip -6 addr add fc00:56::6/64 dev eth2

# Enable forwarding
sysctl -w net.ipv6.conf.all.forwarding=1

# Accept SRv6 traffic
sysctl -w net.ipv6.conf.all.seg6_enabled=1
sysctl -w net.ipv6.conf.lo.seg6_enabled=1
sysctl -w net.ipv6.conf.eth1.seg6_enabled=1
sysctl -w net.ipv6.conf.eth2.seg6_enabled=1

# Configure External network (ext)
cd ~/
rm -rf sr-sfc-demo
git clone https://github.com/SRouting/sr-sfc-demo
cd sr-sfc-demo/config/
sh deploy-term.sh add ext veth1 inet6 fd00:e::1/64 fd00:e::2/64
ip netns exec ext ifconfig lo up
ip netns exec ext ip -6 route add local fc00:e::/64 dev lo

# Configure Routing
ip -6 route add fc00:e::/64 via fd00:e::2
ip -6 route add fc00:3::/64 via fc00:36::3
ip -6 route add fc00:5::/64 via fc00:56::5

# Configure SRv6 End.D6 behaviour for traffic going to Ext
ip -6 route add local fc00:6::d6/128 dev lo

# Configure SR SFC policies for reverse traffic
echo "201 localsid" >> /etc/iproute2/rt_tables
ip -6 rule add from fc00:e::/64 lookup localsid
ip -6 route add fc00:b1::/64 encap seg6 mode encap segs fc00:3::f2:AD61,fc00:2::f1:0,fc00:1::D6 dev eth1 table localsid
ip -6 route add fc00:b2::/64 encap seg6 mode encap segs fc00:5::f3:0,fc00:1::D6 dev eth2 table localsid
