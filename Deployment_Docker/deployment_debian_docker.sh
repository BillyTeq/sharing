#!/bin/bash
#################################################################
#
# Description : fast deployment of debian containers
#
# Auteur : Billyr00t
#
# Date : 20/08/2020
#
#################################################################


if [ "$1" == "--create" ];then
	if [ ! $(docker images | awk '$1 ~ "debian_docker_deployment" {print $3}') ];then
		echo "[!!ERROR!!] You must launch the setup before create containers (./deployment_debian_docker.sh --setup)"
		exit 
	fi

	if [ -z $2 ];then
		nb_machine=1
	else
		nb_machine=$2
	fi

	id_max=`docker ps -a --format '{{.Names}}' | awk -F "-" -v user=${USER} '$0 ~ user"-debian" {print $3}' | sort -r | head -1`
	
	min=$((${id_max} + 1))
	max=$((${id_max} + ${nb_machine}))

	echo "Creation of the container(s)..."
	for i in $(seq ${min} ${max});do
		
		docker run -tid --privileged=true --cap-add NET_ADMIN --cap-add SYS_ADMIN --publish-all=true -v /srv/data:/srv/data -v /sys/fs/cgroup:/sys/fs/cgroup:ro --name ${USER}-debian-${i} -h ${USER}-debian-${i} debian_docker_deployment:v1.0
		docker exec -ti $USER-debian-$i /bin/sh -c "useradd -m -p sa3tHJ3/KuYvI $USER" >> /dev/null ## Le password est chiffré avec cette comande : `perl -e 'print crypt("password", "salt"),"\n"'` 
		docker exec -ti $USER-debian-$i /bin/sh -c "mkdir  ${HOME}/.ssh && chmod 700 ${HOME}/.ssh && chown $USER:$USER $HOME/.ssh"
		docker cp $HOME/.ssh/id_rsa.pub $USER-debian-$i:$HOME/.ssh/authorized_keys
		docker exec -ti $USER-debian-$i /bin/sh -c "chmod 600 ${HOME}/.ssh/authorized_keys && chown $USER:$USER $HOME/.ssh/authorized_keys"
		docker exec -ti $USER-debian-$i /bin/sh -c "echo '$USER   ALL=(ALL) NOPASSWD: ALL'>>/etc/sudoers"
		docker exec -ti $USER-debian-$i /bin/sh -c "service ssh start"

		echo "Container ${USER}-debian-${i} operational."
	done

elif [ "$1" == "--drop" ];then
	docker rm -f $(docker ps -a | awk -v regex="${USER}-debian" '$0 ~ regex {print $1}') >> /dev/null
	echo "All created containers have been deleted."


elif [ "$1" == "--start" ];then
	docker start $(docker ps -a | awk -v regex="${USER}-debian" '$0 ~ regex {print $1}') >> /dev/null
	echo "Stopped containers have been started."

elif [ "$1" == "--infos" ];then
	echo "Informations about the containers : "
	for conteneur in $(docker ps -a | awk -v regex="${USER}-debian" '$0 ~ regex {print $1}');do
		docker inspect -f ' --> Name : {{.Name}} - IP : {{.NetworkSettings.IPAddress}}' $conteneur
	done

elif [ "$1" == "--setup" ];then
	if [ $(dpkg-query -W -f='${Status}' docker 2>/dev/null | grep -c "ok installed") -eq 0 ];then
		echo "################################################"
		echo "Install docker..."
		echo "################################################"
		apt-get install -y docker  
	fi
	if [ ! -f  "Dockerfile_debian_docker_deployment" ];then
		echo "################################################"
		echo "Download the Dockerfile..."
		echo "################################################"
		wget https://raw.githubusercontent.com/BillyTeq/sharing/master/Deployment_Docker/Dockerfile -O Dockerfile_debian_docker_deployment
	fi
	echo "################################################"
	echo "Building the image (it may take a while) ..."
	echo "################################################"
	docker build -t debian_docker_deployment:v1.0 -f Dockerfile_debian_docker_deployment .
	echo "################################################"
	echo "Removing the Dockerfile..."
	echo "################################################"
	rm Dockerfile_debian_docker_deployment
	if [ ! -f  "${HOME}/.ssh/id_rsa.pub" ];then
		echo "################################################"
		echo "Creating ssh key..."
		echo "################################################"
		ssh-keygen -t rsa 4096
	fi
	echo "################################################"
	echo "Installation succeeded."
	echo "Run ./deployment_debian_docker.sh --options to see what you can do."
	echo "################################################"

else
	echo "Options :
	* --create [number] : launch [number] containers (default : 1)
	* --drop : remove all the containers created by this script
	* --infos : informations about the containers (ip, name)
	* --start : start all the containers created by this script
	* --setup : settings up"
fi
