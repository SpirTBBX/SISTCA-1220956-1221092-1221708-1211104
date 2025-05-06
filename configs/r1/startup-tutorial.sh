#!/bin/sh

#vtysh << EOF
#conf t
#ip route 10.10.11.0/24 10.10.99.3
#exit
#EOF

#vtysh << EOF
#conf t
#hostname router1
#password zebra
#enable password zebra
#router ospf
#ospf router-id 1.1.1.1
#network 10.10.10.0/24 area 0
#network 10.10.99.0/29 area 0
#exit
#exit
#write memory
#EOF