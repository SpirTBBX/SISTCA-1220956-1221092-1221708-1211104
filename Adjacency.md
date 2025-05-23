# Adjacency process in _tcpdump_

<!-- TOC -->
* [Adjacency process in _tcpdump_](#adjacency-process-in-_tcpdump_)
    * [OSPF Down](#ospf-down)
    * [OSPF Init](#ospf-init)
    * [OSPF 2-Way](#ospf-2-way)
    * [OSPF ExStart](#ospf-exstart)
    * [OSPF Exchange](#ospf-exchange)
    * [OSPF Loading](#ospf-loading)
    * [OSPF Full](#ospf-full)
<!-- TOC -->

### OSPF Down
- Nenhum router conhece a existência do outro.
```
16:48:07.027729 IP (tos 0xc0, ttl 1, id 12056, offset 0, flags [none], proto OSPF (89), length 64)
    10.10.99.3 > 224.0.0.5: OSPFv2, Hello, length 44
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0)
        Options [External]
          Hello Timer 10s, Dead Timer 40s, Mask 255.255.255.248, Priority 1
          Designated Router 10.10.99.3
16:48:16.776469 IP (tos 0xc0, ttl 1, id 12039, offset 0, flags [none], proto OSPF (89), length 64)
    10.10.99.2 > 224.0.0.5: OSPFv2, Hello, length 44
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0)
        Options [External]
          Hello Timer 10s, Dead Timer 40s, Mask 255.255.255.248, Priority 1
          Designated Router 10.10.99.2
```
### OSPF Init
- Quando um router recebe um Hello de outro router, mas ainda não se vê na mensagem recebida.
```
16:48:17.027713 IP (tos 0xc0, ttl 1, id 12058, offset 0, flags [none], proto OSPF (89), length 68)
    10.10.99.3 > 224.0.0.5: OSPFv2, Hello, length 48
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0)
        Options [External]
          Hello Timer 10s, Dead Timer 40s, Mask 255.255.255.248, Priority 1
          Designated Router 10.10.99.3
          Neighbor List:
            1.1.1.1
```
### OSPF 2-Way
- router1 encontra o seu ID na lista de vizinhos do router3. Está estabelecida a comunicação bidirecional.
```
16:48:17.027894 IP (tos 0xc0, ttl 1, id 12040, offset 0, flags [none], proto OSPF (89), length 52)
    10.10.99.2 > 10.10.99.3: OSPFv2, Database Description, length 32
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0)
        Options [External], DD Flags [Init, More, Master], MTU: 1500, Sequence: 0x11c2351f
16:48:17.027946 IP (tos 0xc0, ttl 1, id 12059, offset 0, flags [none], proto OSPF (89), length 52)
    10.10.99.3 > 10.10.99.2: OSPFv2, Database Description, length 32
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0)
        Options [External], DD Flags [Init, More, Master], MTU: 1500, Sequence: 0x26bdf00b
```
### OSPF ExStart
- É negociada a relação Master/Slave. Isto é visível na presença das flags Init, More e Master no pacote Database Description
```
16:48:17.028021 IP (tos 0xc0, ttl 1, id 12041, offset 0, flags [none], proto OSPF (89), length 72)
    10.10.99.2 > 10.10.99.3: OSPFv2, Database Description, length 52
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0)
        Options [External], DD Flags [none], MTU: 1500, Sequence: 0x26bdf00b
          Advertising Router 1.1.1.1, seq 0x80000005, age 0s, length 28
            Router LSA (1), LSA-ID: 1.1.1.1
            Options: [External]
16:48:17.028067 IP (tos 0xc0, ttl 1, id 12061, offset 0, flags [none], proto OSPF (89), length 112)
    10.10.99.3 > 10.10.99.2: OSPFv2, Database Description, length 92
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0)
        Options [External], DD Flags [Master], MTU: 1500, Sequence: 0x26bdf00c
          Advertising Router 2.2.2.2, seq 0x80000006, age 20s, length 28
            Router LSA (1), LSA-ID: 2.2.2.2
            Options: [External]
          Advertising Router 3.3.3.3, seq 0x80000005, age 20s, length 28
            Router LSA (1), LSA-ID: 3.3.3.3
            Options: [External]
          Advertising Router 3.3.3.3, seq 0x80000001, age 20s, length 12
            Network LSA (2), LSA-ID: 10.10.99.10
            Options: [External]
```
### OSPF Exchange
- Verifica-se pelo envio das tabelas de routing no pacote Database Description com headers Link State Advertisement (LSA)
```
16:48:17.028071 IP (tos 0xc0, ttl 1, id 12062, offset 0, flags [none], proto OSPF (89), length 56)
    10.10.99.3 > 10.10.99.2: OSPFv2, LS-Request, length 36
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0)
          Advertising Router: 1.1.1.1, Router LSA (1), LSA-ID: 1.1.1.1
16:48:17.028099 IP (tos 0xc0, ttl 1, id 12042, offset 0, flags [none], proto OSPF (89), length 52)
    10.10.99.2 > 10.10.99.3: OSPFv2, Database Description, length 32
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0)
        Options [External], DD Flags [none], MTU: 1500, Sequence: 0x26bdf00c
16:48:17.028103 IP (tos 0xc0, ttl 1, id 12043, offset 0, flags [none], proto OSPF (89), length 80)
    10.10.99.2 > 10.10.99.3: OSPFv2, LS-Request, length 60
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0)
          Advertising Router: 2.2.2.2, Router LSA (1), LSA-ID: 2.2.2.2
          Advertising Router: 3.3.3.3, Router LSA (1), LSA-ID: 3.3.3.3
          Advertising Router: 3.3.3.3, Network LSA (2), LSA-ID: 10.10.99.10
```
### OSPF Loading
- Verifica-se pelo pedido de LSAs que sejam desconhecidos do vizinho.
```
16:48:17.028106 IP (tos 0xc0, ttl 1, id 12044, offset 0, flags [none], proto OSPF (89), length 96)
    10.10.99.2 > 10.10.99.3: OSPFv2, LS-Update, length 76
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0), 1 LSA
          LSA #1
          Advertising Router 1.1.1.1, seq 0x80000005, age 1s, length 28
            Router LSA (1), LSA-ID: 1.1.1.1
            Options: [External]
            Router LSA Options: [none]
              Stub Network: 10.10.10.0, Mask: 255.255.255.0
                topology default (0), metric 10
              Stub Network: 10.10.99.0, Mask: 255.255.255.248
                topology default (0), metric 10
16:48:17.028183 IP (tos 0xc0, ttl 1, id 12063, offset 0, flags [none], proto OSPF (89), length 176)
    10.10.99.3 > 10.10.99.2: OSPFv2, LS-Update, length 156
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0), 3 LSAs
          LSA #1
          Advertising Router 2.2.2.2, seq 0x80000006, age 21s, length 28
            Router LSA (1), LSA-ID: 2.2.2.2
            Options: [External]
            Router LSA Options: [none]
              Stub Network: 10.10.11.0, Mask: 255.255.255.0
                topology default (0), metric 10
              Neighbor Network-ID: 10.10.99.10, Interface Address: 10.10.99.11
                topology default (0), metric 10
          LSA #2
          Advertising Router 3.3.3.3, seq 0x80000005, age 21s, length 28
            Router LSA (1), LSA-ID: 3.3.3.3
            Options: [External]
            Router LSA Options: [none]
              Stub Network: 10.10.99.0, Mask: 255.255.255.248
                topology default (0), metric 10
              Neighbor Network-ID: 10.10.99.10, Interface Address: 10.10.99.10
                topology default (0), metric 10
          LSA #3
          Advertising Router 3.3.3.3, seq 0x80000001, age 21s, length 12
            Network LSA (2), LSA-ID: 10.10.99.10
            Options: [External]
            Mask 255.255.255.248
            Connected Routers:
              3.3.3.3
              2.2.2.2
16:48:17.028196 IP (tos 0xc0, ttl 1, id 12065, offset 0, flags [none], proto OSPF (89), length 128)
    10.10.99.3 > 224.0.0.5: OSPFv2, LS-Update, length 108
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0), 2 LSAs
          LSA #1
          Advertising Router 3.3.3.3, seq 0x80000006, age 1s, length 28
            Router LSA (1), LSA-ID: 3.3.3.3
            Options: [External]
            Router LSA Options: [none]
              Neighbor Network-ID: 10.10.99.3, Interface Address: 10.10.99.3
                topology default (0), metric 10
              Neighbor Network-ID: 10.10.99.10, Interface Address: 10.10.99.10
                topology default (0), metric 10
          LSA #2
          Advertising Router 3.3.3.3, seq 0x80000001, age 1s, length 12
            Network LSA (2), LSA-ID: 10.10.99.3
            Options: [External]
            Mask 255.255.255.248
            Connected Routers:
              1.1.1.1
              3.3.3.3
16:48:17.028241 IP (tos 0xc0, ttl 1, id 12045, offset 0, flags [none], proto OSPF (89), length 96)
    10.10.99.2 > 224.0.0.5: OSPFv2, LS-Update, length 76
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0), 1 LSA
          LSA #1
          Advertising Router 1.1.1.1, seq 0x80000006, age 1s, length 28
            Router LSA (1), LSA-ID: 1.1.1.1
            Options: [External]
            Router LSA Options: [none]
              Stub Network: 10.10.10.0, Mask: 255.255.255.0
                topology default (0), metric 10
              Neighbor Network-ID: 10.10.99.3, Interface Address: 10.10.99.2
                topology default (0), metric 10
16:48:18.028198 IP (tos 0xc0, ttl 1, id 12066, offset 0, flags [none], proto OSPF (89), length 64)
    10.10.99.3 > 224.0.0.5: OSPFv2, LS-Ack, length 44
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0)
          Advertising Router 1.1.1.1, seq 0x80000005, age 1s, length 28
            Router LSA (1), LSA-ID: 1.1.1.1
            Options: [External]
16:48:18.028258 IP (tos 0xc0, ttl 1, id 12046, offset 0, flags [none], proto OSPF (89), length 124)
    10.10.99.2 > 224.0.0.5: OSPFv2, LS-Ack, length 104
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0)
          Advertising Router 2.2.2.2, seq 0x80000006, age 21s, length 28
            Router LSA (1), LSA-ID: 2.2.2.2
            Options: [External]
          Advertising Router 3.3.3.3, seq 0x80000005, age 21s, length 28
            Router LSA (1), LSA-ID: 3.3.3.3
            Options: [External]
          Advertising Router 3.3.3.3, seq 0x80000001, age 21s, length 12
            Network LSA (2), LSA-ID: 10.10.99.10
            Options: [External]
          Advertising Router 3.3.3.3, seq 0x80000001, age 1s, length 12
            Network LSA (2), LSA-ID: 10.10.99.3
            Options: [External]
16:48:22.027589 IP (tos 0xc0, ttl 1, id 12067, offset 0, flags [none], proto OSPF (89), length 96)
    10.10.99.3 > 10.10.99.2: OSPFv2, LS-Update, length 76
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0), 1 LSA
          LSA #1
          Advertising Router 3.3.3.3, seq 0x80000006, age 5s, length 28
            Router LSA (1), LSA-ID: 3.3.3.3
            Options: [External]
            Router LSA Options: [none]
              Neighbor Network-ID: 10.10.99.3, Interface Address: 10.10.99.3
                topology default (0), metric 10
              Neighbor Network-ID: 10.10.99.10, Interface Address: 10.10.99.10
                topology default (0), metric 10
16:48:22.028247 IP (tos 0xc0, ttl 1, id 12047, offset 0, flags [none], proto OSPF (89), length 96)
    10.10.99.2 > 10.10.99.3: OSPFv2, LS-Update, length 76
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0), 1 LSA
          LSA #1
          Advertising Router 1.1.1.1, seq 0x80000006, age 6s, length 28
            Router LSA (1), LSA-ID: 1.1.1.1
            Options: [External]
            Router LSA Options: [none]
              Stub Network: 10.10.10.0, Mask: 255.255.255.0
                topology default (0), metric 10
              Neighbor Network-ID: 10.10.99.3, Interface Address: 10.10.99.2
                topology default (0), metric 10
16:48:23.027741 IP (tos 0xc0, ttl 1, id 12048, offset 0, flags [none], proto OSPF (89), length 64)
    10.10.99.2 > 224.0.0.5: OSPFv2, LS-Ack, length 44
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0)
          Advertising Router 3.3.3.3, seq 0x80000006, age 5s, length 28
            Router LSA (1), LSA-ID: 3.3.3.3
            Options: [External]
16:48:23.028334 IP (tos 0xc0, ttl 1, id 12069, offset 0, flags [none], proto OSPF (89), length 64)
    10.10.99.3 > 224.0.0.5: OSPFv2, LS-Ack, length 44
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0)
          Advertising Router 1.1.1.1, seq 0x80000006, age 6s, length 28
            Router LSA (1), LSA-ID: 1.1.1.1
            Options: [External]
```
### OSPF Full
- Ambos os routers sincronizaram suas LSDBs (Link-State Databases). A adjacência está completamente formada.
- Verifica-se pelo retomar de envio de pacotes Hello, após várias mensagens de LS-Update e LS-Ack
```
16:48:26.776488 IP (tos 0xc0, ttl 1, id 12049, offset 0, flags [none], proto OSPF (89), length 68)
    10.10.99.2 > 224.0.0.5: OSPFv2, Hello, length 48
        Router-ID 1.1.1.1, Backbone Area, Authentication Type: none (0)
        Options [External]
          Hello Timer 10s, Dead Timer 40s, Mask 255.255.255.248, Priority 1
          Designated Router 10.10.99.3, Backup Designated Router 10.10.99.2
          Neighbor List:
            3.3.3.3
16:48:27.027746 IP (tos 0xc0, ttl 1, id 12070, offset 0, flags [none], proto OSPF (89), length 68)
    10.10.99.3 > 224.0.0.5: OSPFv2, Hello, length 48
        Router-ID 3.3.3.3, Backbone Area, Authentication Type: none (0)
        Options [External]
          Hello Timer 10s, Dead Timer 40s, Mask 255.255.255.248, Priority 1
          Designated Router 10.10.99.3, Backup Designated Router 10.10.99.2
          Neighbor List:
            1.1.1.1
```