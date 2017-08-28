# Installation de la machine hôte :

## Avec root :
    passwd
    apt-get update
    apt-get upgrade

Créer un adminsitrateur :

    adduser ADMIN
    usermod -aG sudo ADMIN

Ajouter des alias de commande :

    nano /etc/profile.d/00-aliases.sh
        # Ajouter à la fin :
        #
        #   alias ll='ls -lAh --time-style=long-iso'

Empecher le login SSH avec root :

    nano /etc/ssh/sshd_config
        # Modifier :
        #
        # PermitRootLogin no

    service ssh restart

Se déconnecter :

    exit



## Avec ADMIN :

Installation docker :

    sudo apt-get install git curl wget ca-certificates apt-transport-https software-properties-common certbot

    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee -a /etc/apt/sources.list.d/docker.list
    sudo apt-get install docker-ce docker-compose
    
    sudo adduser DOCKER_ADMIN
    sudo usermod -aG docker DOCKER_ADMIN


# Gestion Docker :

    sudo systemctl start docker         # Démarrer le service Docker
    sudo systemctl stop docker          # Stopper le service Docker
    sudo systemctl restart docker       # Re-démarrer le service Docker
    sudo systemctl status docker        # Vérifier l'état du service Docker
    sudo systemctl enable docker        # Démarrage automatique du service Docker


    
## Acceder au shell d'un container :

    docker exec -ti <NOM_DU_CONTENEUR> /bin/bash


## Réseau :

Voir ici : https://docs.docker.com/engine/userguide/networking/#the-default-bridge-network

Création d'un réseau :

    docker network create --driver bridge server_test

## BusyBox :

Lancer une BusyBox "bb1" dans le réseau "server_test" :

    docker run -it --rm --network=server_test --name=bb1 busybox


# Utilisation de broccoli :

## Installation :

Avec DOCKER_ADMIN :

    cd /home/DOCKER_ADMIN
	git clone https://github.com/aurelien35/broccoli

	
## nginx :

    docker network create --driver bridge nginx-network

    start.sh       # démarre l'instance de nginx
    stop.sh        # stoppe ll'instance de nginx
    restart.sh     # re-démarre l'instance de nginx
    reload.sh      # recharge la configuration de nginx
    shell.sh       # Ouvre un shell dans le container nginx
    

## Créer une instance d'un site

    sudo mkdir -p /var/broccoli/<NOM_DU_SITE>
	
Generation du certificat SSL :	

    sudo certbot certonly --webroot -w /home/dockeruser/broccoli/nginx/volumes/data/certbot/www -d <NOM_DU_SITE>.com -d www.<NOM_DU_SITE>.com
	
Pour créer une configuration nginx, copier une des configurations template dans :

	/home/dockeruser/broccoli/nginx/volumes/configuration/sites/<NOM_DU_SITE>.conf


## Créer une instance de mattermost

Créer le site, puis copier le template mattermost dans :

	/var/broccoli/<NOM_DU_SITE>
	
	sudo cp -rf /home/<DOCKER_DAMIN>/broccoli/mattermost /var/broccoli/<NOM_DU_SITE>/
	sudo nano /var/broccoli/<NOM_DU_SITE>/mattermost/docker-compose.yml
	
Créer le réseau correspondant :

    docker network create --driver bridge <NOM_DU_SITE>-mattermost-network
	
Mettre à jour le template et lancer :

    /var/broccoli/<NOM_DU_SITE>/start.sh       # démarre l'instance de mattermost
    /var/broccoli/<NOM_DU_SITE>/stop.sh        # stoppe ll'instance de mattermost
    /var/broccoli/<NOM_DU_SITE>/restart.sh     # re-démarre l'instance de mattermost




############################################################################	
	
IMPORTANT NOTES:
 - Congratulations! Your certificate and chain have been saved at
   /etc/letsencrypt/live/radiopochard.com/fullchain.pem. Your cert
   will expire on 2017-11-26. To obtain a new or tweaked version of
   this certificate in the future, simply run certbot again. To
   non-interactively renew *all* of your certificates, run "certbot
   renew"
 - If you lose your account credentials, you can recover through
   e-mails sent to aurelien.albert@outlook.com.
 - Your account credentials have been saved in your Certbot
   configuration directory at /etc/letsencrypt. You should make a
   secure backup of this folder now. This configuration directory will
   also contain certificates and private keys obtained by Certbot so
   making regular backups of this folder is ideal.
 - If you like Certbot, please consider supporting our work by:
	




    
    
    
    
    
