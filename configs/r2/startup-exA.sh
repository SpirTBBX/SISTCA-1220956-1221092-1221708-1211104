#!/bin/sh

vtysh << EOF
conf t
ip route 10.10.10.0/24 10.10.99.10
exit
EOF