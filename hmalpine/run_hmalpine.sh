#!/bin/bash
NOMCONTAINER="hmalpine"
ISCREATED=`docker ps --filter="name=$NOMCONTAINER" -q -a | wc -l`
ISRUNNING=`docker ps --filter="name=$NOMCONTAINER" -q | wc -l`
if [ $ISRUNNING -eq 1 ]; then
        echo "Container $NOMCONTAINER est déjà en cours..."
        docker ps --filter="name=$NOMCONTAINER"
elif [ $ISCREATED -eq 1 ]; then
        echo "Redémarrage du container $NOMCONTAINER"
        docker start $NOMCONTAINER
else
	if [ ! -d "/var/www" ]; then
  		echo "Le répertoire /var/www n'existe pas : le container ne sera pas lancé"
		exit 1
	fi
	if [ ! -d "/var/log/apache2" ]; then
  		echo "Le répertoire /var/log/apache2 n'existe pas : le container ne sera pas lancé"
		exit 1
	fi
        echo "Lancement du container $NOMCONTAINER à partir de l'image"
	docker run -p 80:80 -h "$NOMCONTAINER" --name "$NOMCONTAINER" --restart=always -v /var/www:/var/www -v /var/log:/var/log -e TZ='Europe/Paris' -dti $NOMCONTAINER
fi
cat << EOF
        Pour ouvrir un shell dans le container : docker exec -ti $NOMCONTAINER bash
        Pour arreter le container : docker stop $NOMCONTAINER
        Pour arrêter définitivement le container (empêcher la relance au reboot) : docker stop $NOMCONTAINER && docker rm $NOMCONTAINER
EOF
