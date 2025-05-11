# Challenge Solution
- Configure router1's startup to get the interface names for the router1-3 and router1-4 links and configure costs through the vtysh startup section. The `startup.sh` file of router1 should have the following configuration:
```bash
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
ip ospf cost 50
interface $ROUTER4_IFACE
ip ospf cost 20
exit
write memory
exit
EOF
```

- Start the docker compose file from the exercise B and open two `sh` shells on router1;
- In one of the shells run `ip -o -4 addr show` and identify the router1-3 an router1-4 link interfaces;
- In each shell, run `iftop -i ROUTER1-3_INTERFACE_NAME` and `iftop -i ROUTER1-4_INTERFACE_NAME`. This will allow you to see the traffic on each interface of router1;
- In the srv container, start an `iperf` server with `iperf3 -s`;
- Open a shell in the host container and run `iperf3 -c 10.10.11.2 -P 4`, where `-P` specifies the number of stream flows. This can be any number, but we've used 4 to make the test quicker;
- According to the costs set in the router1 `startup.sh` file, traffic will be sent only through one of the links unless we stop one of the interfaces. If only one link is available, the cost will be ignored as there needs to be a way to establish a connection. In the example of the config above, traffic will only be seen through the router1-4 interface as the cost of router3 is higher. Higher cost means lower priority;
- Costs can be seen, through the an `sh` shell, by using the command `vtysh -c "show ip ospf interface"`;