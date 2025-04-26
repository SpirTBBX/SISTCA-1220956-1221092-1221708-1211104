#!/bin/sh

#ip route add 55.73.20.0/24 via 23.10.49.3

vtysh << EOF
conf t
ip route 55.73.20.0/24 23.10.49.3
exit
EOF