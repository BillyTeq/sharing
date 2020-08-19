# Installation d'un contenteur ossec-server

Le script `install.sh` permet de réaliser l'installation d'un conteneur ossec-server écoutant sur le réseau hôte.
	
1. Installation des dépendances nécessaires. Ces dépendances sont :
	- docker
	- docker-compose

2. Lancement du service docker.

3. Import de l'image `ossec-server`. L'image `ossec-server` est basé sur une image alpine dans lequel a été ajouté :
	- le paquet ossec-hids-3.6.0-r0.apk
	- le paquet ossec-hids-openrc-3.6.0-r0.apk
	- le paquet ossec-hids-server-3.6.0-r0.apk
	- le paquet tzdata (`apk add dzdata`) pour synchroniser l'horloge sur Paris. Il a été supprimé ensuite.
	
4. Lancement du contenteur ossec-server.
 	
