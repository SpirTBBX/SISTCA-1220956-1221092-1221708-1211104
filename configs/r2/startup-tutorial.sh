#!/bin/sh

#ip route add 55.73.20.0/24 via 95.120.2.67
#ip route add 37.8.181.0/24 via 6.80.75.10

# vtysh << EOF
# conf t
# ip route 10.10.10.0/24 10.10.99.2
# exit
# EOF