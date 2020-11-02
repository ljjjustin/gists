#!/bin/bash

ip route flush table 200
ip route add 169.254.62.0/24 dev bond2 table 200
ip route add default via 169.254.62.254 table 200

ipaddr=$(ip r get 169.254.62.254 | grep src | awk '{print $NF}')
if ! ip ru | grep -qw ${ipaddr}; then
	ip rule add from ${ipaddr} table 200
fi
