#!/bin/sh

vtysh << EOF
conf t
hostname router4
password zebra
enable password zebra
router ospf
ospf router-id 4.4.4.4
network 10.10.99.16/29 area 0
network 10.10.99.24/29 area 0
exit
exit
write memory
EOF