#!/bin/bash

NOCOLOR='\033[0m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'

file=/var/ossec/queue/rids/sender

echo "------------------------------------"
echo -e "${GREEN}Script installation de l'agent OSSEC${NOCOLOR}"
echo "------------------------------------"

read -p 'IP du serveur Ossec : ' serveur 

echo "------------------------------------"
echo -e "${BLUE}1. Installation des dependances${NOCOLOR}"
echo "------------------------------------"

yum install -y gcc
yum install -y pcre2
rpm -Uvh dependencies-rpm/pcre2-utf16-10.23-2.el7.art.x86_64.rpm
rpm -Uvh dependencies-rpm/pcre2-utf32-10.23-2.el7.art.x86_64.rpm 

echo "------------------------------------"
echo -e "${BLUE}2. Installation du paquet ossec-hids${NOCOLOR}"
echo "------------------------------------"

rpm -Uvh ossec-rpm/ossec-hids-3.6.0-11279.el7.art.x86_64.rpm 

echo "------------------------------------"
echo -e "${BLUE}3. Installation du paquet ossec-hids-agent${NOCOLOR}"
echo "------------------------------------"

rpm -Uvh ossec-rpm/ossec-hids-agent-3.6.0-11279.el7.art.x86_64.rpm

echo "------------------------------------"
echo -e "${BLUE}4. Copie du nouveau fichier ossec-agent.conf${NOCOLOR}"
echo -e "${BLUE}5. Création du nouveau fichier sender${NOCOLOR}"
echo "------------------------------------"

cp conf-file/ossec-agent.conf /var/ossec/etc/ossec-agent.conf

if [ ! -f "$FILE"]; then
	touch /var/ossec/queue/rids/sender
fi


echo "------------------------------------"
echo -e "${BLUE}6. Connexion au serveur OSSEC...${NOCOLOR}"
echo "------------------------------------"
/var/ossec/bin/agent-auth -m $serveur

echo "------------------------------------"
echo -e "${BLUE}7. Démarrage du service OSSEC${NOCOLOR}"
echo "------------------------------------"
/var/ossec/bin/ossec-control start

echo "------------------------------------"
echo -e "${YELLOW}Done.${NOCOLOR}"
echo "------------------------------------"


