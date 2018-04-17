#!/bin/bash

# Install required softwares
export DEBIAN_FRONTEND=noninteractive
apt-get -y update
apt-get -y upgrade
apt-get -y install build-essential libpcap-dev git

# Interfaces configuration
ifconfig eth1 up
ip -6 addr add fc00:14::4/64 dev eth1

ifconfig eth2 up
ip -6 addr add fc00:45::4/64 dev eth2

# Enable forwarding
sysctl -w net.ipv6.conf.all.forwarding=1

# Install SR-tcpdump
cd ~/
git clone https://github.com/srouting/sr-tcpdump
cd sr-tcpdump
./configure && make && make install

# Configure Routing
ip -6 route add fc00:5::/64 via fc00:45::5
ip -6 route add fc00:1::/64 via fc00:14::1
