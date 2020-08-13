#!/bin/bash

NOCOLOR='\033[0m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'

echo "------------------------------------"
echo -e "${GREEN}Script deinstallation de l'agent OSSEC${NOCOLOR}"
echo "------------------------------------"

echo "------------------------------------"
echo -e "${BLUE}1. Arret de l'agent OSSEC${NOCOLOR}"
echo "------------------------------------"

/var/ossec/bin/ossec-control stop

echo "------------------------------------"
echo -e "${BLUE}2. Déinstallation des dépendances${NOCOLOR}"
echo "------------------------------------"

yum remove pcre2
yum remove gcc
rpm -e pcre2-utf16-10.23-2.el7.art.x86_64
rpm -e pcre2-utf32-10.23-2.el7.art.x86_64

echo "------------------------------------"
echo -e "${BLUE}3. Déinstallation du paquet ossec-hids${NOCOLOR}"
echo "------------------------------------"

rpm -e ossec-hids-3.6.0-11279.el7.art.x86_64

echo "------------------------------------"
echo -e "${BLUE}4. Suppression des fichiers OSSEC${NOCOLOR}"
echo "------------------------------------"

rm -rf /var/ossec

echo "------------------------------------"
echo -e "${YELLOW}Done.${NOCOLOR}"
echo "------------------------------------"

echo "---------------------------------------------------------------------"
echo -e "${RED}Ne pas oublier d'enlever manuellement l'agent sur le server${NOCOLOR}"
echo "---------------------------------------------------------------------"
