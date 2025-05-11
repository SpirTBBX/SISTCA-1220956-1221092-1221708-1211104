#!/bin/sh

ROUTER3_IFACE=$(ip -o -4 addr show | awk '/10.10.99.2\// {print $2}')
ROUTER4_IFACE=$(ip -o -4 addr show | awk '/10.10.99.18\// {print $2}')

echo "Router1 interface to communicate with Router3: $ROUTER3_IFACE"
echo "Router1 interface to communicate with Router4: $ROUTER4_IFACE"

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
interface $ROUTER3_IFACE
ip ospf cost 20
interface $ROUTER4_IFACE
ip ospf cost 20
exit
write memory
exit
EOF