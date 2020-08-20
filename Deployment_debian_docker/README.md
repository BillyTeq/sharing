# Créer des conteneurs docker debian10 rapidement + connexion ssh

## Présentation 

Le script `deployment_debian_docker.sh` permet de créer **facilement** et **rapidement** des conteneurs docker debian 10. Les conteneurs créés par ce script sont accessible en `ssh` depuis la machine hôte.  

## Usage

Voici les options que propose ce script :

L'action `--setup` permet d'installer les requis pour l'utilisation de ce script.
L'action `--create [number]` permet de créer un nombre donné de conteneur. Si le nombre n'est pas spécifié, seul un conteneur sera créé.<br>
L'action `--drop` permet de supprimer tous les conteneurs (en marche ou non) qui ont été créé par ce script.<br>
L'action `--infos` permet d'afficher le nom et l'IP de chaque conteneur.<br>
L'action `--start` permet de démarrer tous les conteneurs qui ont été créé par ce script.<br>

## Setup

Lors du `setup` :
  * Installation de du binaire `docker`
  * Téléchargement du `Dockerfile` disponible [ici](https://github.com/BillyTeq/sharing/blob/master/Deployment_debian_docker/Dockerfile) 
  * Construction de l'image `debian_docker_deployment` avec le `Dockerfile`
  * Suppression du `Dockerfile`
  * Création d'une clé ssh RSA de 4096 bits

## SSH

Lors de la connexion `ssh` avec un conteneur, il est possible de se connecter avec le nom d'utilisateur qui est inscrit dans le nom du conteneur (`<name>-debian-<number>`).<br>
Grâce à la clé publique ssh de la machine hôte prédisposé dans ce dernier, il n'y a pas besoin de rentrer de mot de passe. Par défaut, le mot de passe de l'utilisateur du conteneur (le même nom que l'utilisateur qui a utilisé le script') est `password`.<br>

## À savoir

**Attention ces conteneurs sont absolument fait pour du test (absolument pas sécurisés).**<br>
Il est possible d'utiliser la commande `sudo` sans mot de passe.<br>
Les ports ouverts sont exposés à l'extérieur du conteneur et donc disponible depuis la machine hôte.<br> 

