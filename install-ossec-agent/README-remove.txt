Suppression d'un agent OSSEC :

	Le script remove-ossec-agent permet de supprimer un agent ossec.

	1. Arrêt de l'agent OSSEC.

	2. Déinstallation des dépendances nécessaires. Ces dépendances sont :
		- gcc (https://gcc.gnu.org/)
		- pcre2 (https://www.pcre.org/current/doc/html/pcre2.html)
		- libpcre2-16.so.0
		- libpcre2-32.so.0
	
	3. Installation du package ossec-hids (ossec-hids-3.6.0-11279.el7.art.x86_64.rpm).

	4. Suppression de tous les fichiers créés par l'installation d'OSSEC.

