# Commenter/décommenter des règles/décodeurs Wazuh

## Présentation 

Ce script `action_wazuh.py` permet de commenter ou de décommenter des décodeurs ou des règles wazuh définies au format xml.

Le script utilise les deux fichiers `comment_wazuh.awk` et `uncomment_wazuh.awk`.
Les trois fichiers doivent être stockés obligatoirement dans le même répertoire.

Le script `action_wazuh.py` doit être executé avec python3.

## Usage

Voici l'usage de ce script : `python3 action_wazuh.py (-c|-u) (-r|-d) -i INPUT_FILE [-o OUTPUT_FILE] [-t arg1 arg2 ...]` : <br>
L'action -c permet de commenter, l'action -u permet de décommenter (l'utilisation d'une de ces deux actions est obligatoire).<br>
L'option -r spécifie que ce sont des règles qui vont être commentées, l'option -d spécifie que ce sont des décodeurs qui vont être commentés (l'utilisation d'une de ces deux options est obligatoire).<br>
L'option "-i" est obligatoire, elle permet de spécifier le fichier d'entrée.<br>
L'option "-o" est optionnelle, elle permet de spécifier le fichier sur lequel les modifications vont être effectuées. Si elle n'est pas spécifiée, les modifications seront faites sur le fichier d'entrée.<br>
L'option `-t` est optionnelle, elle permet de spécifier des règles en arguments qui vont écraser la configuration présente dans le fichier `action_wazuh_rules.py`. (voir [la partie configuration](#Configuration))<br>

## Configuration 

Pour sélectionner les règles/decodeurs à commenter ou à décommenter, l'utilisateur doit inscrire leurs ids/noms en modifiant leur tableau respectif dans la partie `CONFIGURATION (DECODERS NAMES|ID RULES)` du script.<br>

Par exemple pour faire une action sur les décodeurs "decodeur1", "decodeur2" et "decodeur3", l'utilisateur définira le tableau suivant:
`WAZUH_DECODERSs=["decodeur1","decodeur2","decodeur3"]`.

L'option `-h` ou `--help` permet d'avoir plus d'informations sur l'utilisation du script. 
Les fichiers `test_decoders.xml` et `test_rules.xml` sont disponibles pour tester ce script.
