```
router1# show ip route
Codes: K - kernel route, C - connected, L - local, S - static,
       R - RIP, O - OSPF, I - IS-IS, B - BGP, E - EIGRP, N - NHRP,
       T - Table, v - VNC, V - VNC-Direct, A - Babel, F - PBR,
       f - OpenFabric, t - Table-Direct,
       > - selected route, * - FIB route, q - queued, r - rejected, b - backup
       t - trapped, o - offload failure

K>* 0.0.0.0/0 [0/0] via 10.10.10.1, eth1, weight 1, 00:09:09
O   10.10.10.0/24 [110/10] is directly connected, eth1, weight 1, 00:09:03
C>* 10.10.10.0/24 is directly connected, eth1, weight 1, 00:09:09
L>* 10.10.10.254/32 is directly connected, eth1, weight 1, 00:09:09
O   10.10.99.0/29 [110/10] is directly connected, eth0, weight 1, 00:09:03
C>* 10.10.99.0/29 is directly connected, eth0, weight 1, 00:09:09
L>* 10.10.99.2/32 is directly connected, eth0, weight 1, 00:09:09

```
Procurar o interface que tem o IP 10.10.99.2 -> Neste caso, **eth0**
```
router1# configure terminal
router1(config)# interface eth0
router1(config-if)# no ip ospf passive
router1(config-if)# exit
router1(config)# exit
router1# write memory
Note: this version of vtysh never writes vtysh.conf
Building Configuration...
Configuration saved to /etc/frr//mgmtd.conf
Configuration saved to /etc/frr/zebra.conf
Configuration saved to /etc/frr/ospfd.conf
Configuration saved to /etc/frr/staticd.conf

```
