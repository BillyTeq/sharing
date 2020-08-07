# Commenter/décommenter des décodeurs Wazuh

## Présentation 

Ce script `action_wazuh_decoders.py` permet de commenter ou de décommenter des décodeurs wazuh définies au format xml.

Le script utilise les deux fichiers `comment_wazuh_decoders.awk` et `uncomment_wazuh_decoders.awk`.
Les trois fichiers doivent être stockés obligatoirement dans le même répertoire.

Le script `action_wazuh_decoderss.py` doit être executé avec python3.

## Usage

Voici l'usage de ce script : `python3 action_wazuh_decoders.py (-c|-u) -i INPUT_FILE [-o OUTPUT_FILE]` : <br>
L'action -c permet de commenter, l'action -u permet de décommenter (l'utilisation d'une de ces deux actions est obligatoire).<br>
L'option "-i" est obligatoire, elle permet de spécifier le fichier d'entrée.<br>
L'option "-o" est optionnelle, elle permet de spécifier le fichier sur lequel les modifications vont être effectuées. Si elle n'est pas spécifiée, les modifications seront faites sur le fichier d'entrée.<br>

## Règles 

Pour sélectionner les decoders à commenter/décommenter, l'utilisateur doit inscrire leurs noms en modifiant le tableau `WAZUH_DECODERS` dans la partie `CONFIGURATION DECODERS NAMES` du script.<br>
Par exemple pour faire une action sur les décodeurs "decodeur1", "decodeur2" et "decodeur3", l'utilisateur définira le tableau suivant:
`WAZUH_DECODERSS=["decodeur1","decodeur2","decodeur3"]`

L'option `-h` ou `--help` permet d'avoir plus d'informations sur l'utilisation du script. 
