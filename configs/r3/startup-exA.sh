#!/bin/sh

#ip route add 37.8.181.0/24 via 23.10.49.2

vtysh << EOF
conf t
ip route 10.10.10.0/24 10.10.99.2
ip route 10.10.11.0/24 10.10.99.11
exit
EOF