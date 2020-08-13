Installation d'un agent OSSEC :

	Le script install-ossec-agent permet de réaliser l'installation d'un agent ossec.
	
	1. Installation des dépendances nécessaires. Ces dépendances sont :
		- gcc (https://gcc.gnu.org/)
		- pcre2 (https://www.pcre.org/current/doc/html/pcre2.html)
		- libpcre2-16.so.0 (disponible dans le répertoire dependencies-rpm)
		- libpcre2-32.so.0 (disponible dans le répertoire dependencies-rpm)

	2. Installation du package ossec-hids (disponible dans le répertoire ossec-rpm).
	   Ce package se nomme "ossec-hids-3.6.0-11279.el7.art.x86_64.rpm".

	3. Installation du package ossec-hids-agent (disponible dans le répertoire ossec-rpm).
	   Ce package se nomme "ossec-hids-agent-3.6.0-11279.el7.art.x86_64.rpm".

	4. Copie du fichier ossec-agent.conf (disponible dans le répertoire conf-file) à la place
           de celui qu'instancie par défaut le paquet "ossec-hids". Sur la machine il sera stocké
           dans le réperoire "/var/ossec/etc/".
 	
	5. Creation du fichier /var/ossec/queue/rids/sender s'il n'existe pas.

	6. L'hôte se connecte au serveur OSSEC sur le port 1515 pour son authentification. Par défaut,
	   il n'y pas de mot de passe. Sur le serveur OSSEC pourra le reconnaître avec son nom d'hôte.

	7. Démarrage de l'agent OSSEC.
