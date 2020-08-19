#!/bin/bash

NOCOLOR='\033[0m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'


echo "------------------------------------"
echo -e "${GREEN}Script installation de l'agent WAZUH${NOCOLOR}"
echo "------------------------------------"

read -p 'IP du serveur Wazuh : ' serveur 

echo "------------------------------------"
echo -e "${BLUE}1. Installation du paquet wazuh-agent${NOCOLOR}"
echo -e "${BLUE}Version de Wazuh : 3.12.3${NOCOLOR}"
echo "------------------------------------"

rpm -Uvh wazuh-rpm/wazuh-agent-3.12.3-1.x86_64.rpm

echo "------------------------------------"
echo -e "${BLUE}2. Copie du nouveau fichier ossec.conf${NOCOLOR}"
echo "------------------------------------"

cp conf-file/ossec.conf /var/ossec/etc/ossec.conf

echo "------------------------------------"
echo -e "${BLUE}3. Connexion au serveur OSSEC...${NOCOLOR}"
echo "------------------------------------"
/var/ossec/bin/agent-auth -m $serveur

echo "------------------------------------"
echo -e "${BLUE}4. Démarrage du service OSSEC${NOCOLOR}"
echo "------------------------------------"
/var/ossec/bin/ossec-control start

echo "------------------------------------"
echo -e "${YELLOW}Done.${NOCOLOR}"
echo "------------------------------------"


