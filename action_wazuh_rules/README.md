# Commenter/décommenter des règles Wazuh

## Présentation 

Ce script `action_wazuh_rules.py` permet de commenter ou de décommenter des règles wazuh définies au format xml.

Le script utilise les deux fichiers `comment_wazuh_rules.awk` et `uncomment_wazuh_rules.awk`.
Les trois fichiers doivent être stockés obligatoirement dans le même répertoire.

Le script `action_wazuh_rules.py` doit être executé avec python3.

## Usage

Voici l'usage de ce script : `python3 action_wazuh_rules.py (-c|-u) -i INPUT_FILE [-o OUTPUT_FILE]` : <br>
L'action -c permet de commenter, l'action -u permet de décommenter (l'utilisation d'une de ces deux actions est obligatoire).<br>
L'option "-i" est obligatoire, elle permet de spécifier le fichier d'entrée.<br>
L'option "-o" est optionnelle, elle permet de spécifier le fichier sur lequel les modifications vont être effectuées. Si elle n'est pas spécifiée, les modifications seront faites sur le fichier d'entrée.<br>

## Règles 

Pour sélectionner les règles à commenter/décommenter, l'utilisateur doit inscrire leurs ids en modifiant le tableau `WAZUH_RULES` dans la partie `CONFIGURATION ID RULES` du script.<br>
Par exemple pour faire une action sur les règles 123, 345 et 567, l'utilisateur définira le tableau suivant:
`WAZUH_RULES=[123,345,567]`

L'option `-h` ou `--help` permet d'avoir plus d'informations sur l'utilisation du script. 
