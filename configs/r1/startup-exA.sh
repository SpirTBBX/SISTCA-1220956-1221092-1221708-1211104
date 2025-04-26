#!/bin/sh

vtysh << EOF
conf t
ip route 10.10.11.0/24 10.10.99.3
exit
EOF