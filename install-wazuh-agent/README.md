# Installation d'un agent WAZUH

Le script install-wazuh-agent permet de réaliser l'installation d'un agent wazuh. Version de Wazuh : 3.12.3
	
0. Stockage de l'IP du serveur Wazuh pour la connection entre agent et serveur à l'étape 5.

1. Installation du package wazuh-agent (disponible dans le répertoire wazuh-rpm). Ce package se nomme `wazuh-agent-3.12.3-1.x86_64.rpm`.

2. Copie du fichier ossec.conf (disponible dans le répertoire conf-file) à la place de celui qu'instancie par défaut le paquet `wazuh-hids`. Sur la machine il sera stocké dans le réperoire `/var/ossec/etc/`.

3. L'hôte se connecte au serveur Wazuh sur le port `1515` pour son authentification. Par défaut, il n'y pas de mot de passe. Le serveur Wazuh pourra le reconnaître avec son nom d'hôte.

4. Démarrage de l'agent Wazuh.
	
  
# Suppression d'un agent WAZUH

Le script `remove-wazuh-agent` permet de supprimer uun agent wazuh.

1. Arrêt de l'agent WAZUH.
	
2. Deinstallation du package wazuh-agent (`wazuh-agent-3.12.3-1.x86_64.rpm`).

3. Suppression de tous les fichiers créés par l'installation de Wazuh.
