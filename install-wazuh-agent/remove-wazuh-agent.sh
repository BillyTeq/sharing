#!/bin/bash

NOCOLOR='\033[0m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'

echo "------------------------------------"
echo -e "${GREEN}Script deinstallation de l'agent WAZUH${NOCOLOR}"
echo "------------------------------------"

echo "------------------------------------"
echo -e "${BLUE}1. Arret de l'agent WAZUH${NOCOLOR}"
echo "------------------------------------"

/var/ossec/bin/ossec-control stop

echo "------------------------------------"
echo -e "${BLUE}2. Déinstallation du paquet wazuh-agent${NOCOLOR}"
echo -e "${BLUE}Version de Wazuh : 3.12.3${NOCOLOR}"
echo "------------------------------------"

rpm -e wazuh-agent-3.12.3-1.x86_64

echo "------------------------------------"
echo -e "${BLUE}3. Suppression des fichiers WAZUH${NOCOLOR}"
echo "------------------------------------"

rm -rf /var/ossec

echo "------------------------------------"
echo -e "${YELLOW}Done.${NOCOLOR}"
echo "------------------------------------"

echo "---------------------------------------------------------------------"
echo -e "${RED}Ne pas oublier d'enlever manuellement l'agent sur le server${NOCOLOR}"
echo "---------------------------------------------------------------------"
