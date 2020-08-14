# Installation d'un agent OSSEC

Le script `install-ossec-agent` permet de réaliser l'installation d'un agent ossec.
	
Installation des dépendances nécessaires. Ces dépendances sont :
	- `gcc` (https://gcc.gnu.org/)
	- `pcre2` (https://www.pcre.org/current/doc/html/pcre2.html)
	- `libpcre2-16.so.0`(disponible dans le répertoire dependencies-rpm)
	- `libpcre2-32.so.0` (disponible dans le répertoire dependencies-rpm)

Installation du package `ossec-hids` (disponible dans le répertoire ossec-rpm). Ce package se nomme `ossec-hids-3.6.0-11279.el7.art.x86_64.rpm`.

Installation du package ossec-hids-agent (disponible dans le répertoire ossec-rpm). Ce package se nomme `ossec-hids-agent-3.6.0-11279.el7.art.x86_64.rpm`.

Copie du fichier ossec-agent.conf (disponible dans le répertoire conf-file) à la place de celui qu'instancie par défaut le paquet "ossec-hids". Sur la machine il sera stocké dans le réperoire `/var/ossec/etc/`.

Creation du fichier `/var/ossec/queue/rids/sender` s'il n'existe pas.

L'hôte se connecte au serveur OSSEC sur le port `1515` pour son authentification. Par défaut, il n'y pas de mot de passe. Sur le serveur OSSEC pourra le reconnaître avec son nom d'hôte.

Démarrage de l'agent OSSEC.
	
# Suppression d'un agent OSSEC 

Le script `remove-ossec-agent` permet de supprimer un agent ossec.

Arrêt de l'agent OSSEC.

Déinstallation des dépendances nécessaires. Ces dépendances sont :
	- [gcc](https://gcc.gnu.org/)
	- [pcre2](https://www.pcre.org/current/doc/html/pcre2.html)
	- libpcre2-16.so.0
	- libpcre2-32.so.0
	
Installation du package ossec-hids (`ossec-hids-3.6.0-11279.el7.art.x86_64.rpm`).

Suppression de tous les fichiers créés par l'installation d'OSSEC.

