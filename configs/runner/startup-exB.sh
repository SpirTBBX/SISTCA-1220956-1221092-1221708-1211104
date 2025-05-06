#!/bin/sh

# Give execution permissions to the startup script on all containers
docker exec router1 chmod +x /etc/startup-exB.sh
docker exec router2 chmod +x /etc/startup-exB.sh
docker exec router3 chmod +x /etc/startup-exB.sh
docker exec router4 chmod +x /etc/startup-exB.sh
docker exec host chmod +x /etc/startup.sh
docker exec srv chmod +x /etc/startup.sh

# Execute the startup-tutorial script on all containers
docker exec router1 /etc/startup-exB.sh
docker exec router2 /etc/startup-exB.sh
docker exec router3 /etc/startup-exB.sh
docker exec router4 /etc/startup-exB.sh
docker exec host /etc/startup.sh
docker exec srv /etc/startup.sh