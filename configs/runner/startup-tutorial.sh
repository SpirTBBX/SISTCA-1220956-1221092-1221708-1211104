#!/bin/sh

# Give execution permissions to the startup script on all containers
docker exec router1 chmod +x /etc/startup-tutorial.sh
docker exec router2 chmod +x /etc/startup-tutorial.sh
docker exec host chmod +x /etc/startup-tutorial.sh
docker exec srv chmod +x /etc/startup-tutorial.sh

# Execute the startup-tutorial script on all containers
docker exec router1 /etc/startup-tutorial.sh
docker exec router2 /etc/startup-tutorial.sh
docker exec host /etc/startup-tutorial.sh
docker exec srv /etc/startup-tutorial.sh