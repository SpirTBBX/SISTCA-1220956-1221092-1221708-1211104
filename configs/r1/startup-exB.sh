#!/bin/sh

vtysh << EOF
conf t
hostname router1
password zebra
enable password zebra
router ospf
ospf router-id 1.1.1.1
network 10.10.10.0/24 area 0
network 10.10.99.0/29 area 0
network 10.10.99.16/29 area 0
exit
exit
write memory
EOF