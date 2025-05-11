#!/bin/sh

# Give execution permissions to the startup script on all containers
echo "Router 1 permission"
docker exec router1 chmod +x /etc/startup.sh
echo "Router 2 permission"
docker exec router2 chmod +x /etc/startup.sh
echo "Host permission"
docker exec host chmod +x /etc/startup.sh
echo "Server permission"
docker exec srv chmod +x /etc/startup.sh

# Execute the startup script on all containers
echo "Router 1 execution"
docker exec router1 /etc/startup.sh
echo "Router 2 execution"
docker exec router2 /etc/startup.sh
echo "Host execution"
docker exec host /etc/startup.sh
echo "Server execution"
docker exec srv /etc/startup.sh