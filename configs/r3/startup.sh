#!/bin/sh

#ip route add 37.8.181.0/24 via 23.10.49.2

vtysh << EOF
conf t
ip route 37.8.181.0/24 23.10.49.2
exit
EOF