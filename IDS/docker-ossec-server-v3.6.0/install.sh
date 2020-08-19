#!/bin/bash


NOCOLOR='\033[0m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'


echo "----------------------------------------------------"
echo -e "${GREEN}Script installation du conteneur ossec-server${NOCOLOR}"
echo "----------------------------------------------------"

echo "----------------------------------------------------"
echo -e "${BLUE}1. Installation des dependances${NOCOLOR}"
echo "----------------------------------------------------"

yum install -y docker docker-compose

echo "----------------------------------------------------"
echo -e "${BLUE}2. Démarrage du service docker${NOCOLOR}"
echo "----------------------------------------------------"

systemctl start docker

echo "----------------------------------------------------"
echo -e "${BLUE}3. Import de l'image ossec-server (cf README.md)${NOCOLOR}"
echo "----------------------------------------------------"

docker load < ossec-server.tar.gz

echo "----------------------------------------------------"
echo -e "${BLUE}4. Lancement du conteneur${NOCOLOR}"
echo "----------------------------------------------------"

docker-compose up -d 

echo "----------------------------------------------------"
echo -e "${YELLOW}Done.${NOCOLOR}"
echo "----------------------------------------------------"

echo "----------------------------------------------------"
echo -e "${RED}Pour entrer dans le conteneur :"
echo -e "docker exec -ti ossec-server sh${NOCOLOR}"
echo "----------------------------------------------------"
