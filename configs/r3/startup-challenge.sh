#!/bin/sh

#ip route add 37.8.181.0/24 via 23.10.49.2

# vtysh << EOF
# conf t
# ip route 10.10.10.0/24 10.10.99.2
# ip route 10.10.11.0/24 10.10.99.11
# exit
# EOF

vtysh << EOF
conf t
hostname router3
password zebra
enable password zebra
router ospf
ospf router-id 3.3.3.3
network 10.10.99.0/29 area 0
network 10.10.99.8/29 area 0
exit
exit
write memory
EOF