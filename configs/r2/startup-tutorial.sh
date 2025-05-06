#!/bin/sh

# vtysh << EOF
# conf t
# ip route 10.10.10.0/24 10.10.99.2
# exit
# EOF

#vtysh << EOF
#conf t
#hostname router2
#password zebra
#enable password zebra
#router ospf
#ospf router-id 2.2.2.2
#network 10.10.11.0/24 area 0
#network 10.10.99.0/29 area 0
#exit
#exit
#write memory
#EOF