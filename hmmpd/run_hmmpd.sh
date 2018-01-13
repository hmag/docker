#!/bin/bash
NOMCONTAINER="hmmpd"
ISCREATED=`docker ps --filter="name=$NOMCONTAINER" -q -a | wc -l`
ISRUNNING=`docker ps --filter="name=$NOMCONTAINER" -q | wc -l`
if [ $ISRUNNING -eq 1 ]; then
        echo "Container $NOMCONTAINER est déjà en cours..."
        docker ps --filter="name=$NOMCONTAINER"
elif [ $ISCREATED -eq 1 ]; then
        echo "Redémarrage du container $NOMCONTAINER"
        docker start $NOMCONTAINER
else
	if [ ! -d "/var/mpd" ]; then
  		echo "Le répertoire /var/mpd n'existe pas : le container ne sera pas lancé"
		exit 1
	fi
        echo "Lancement du container $NOMCONTAINER à partir de l'image"
	docker run -p 6600:6600 -h "$NOMCONTAINER" --name "$NOMCONTAINER" --device /dev/snd --restart=always -v /var/mpd:/var/mpd -e TZ='Europe/Paris' -dti $NOMCONTAINER
fi
cat << EOF
        Pour ouvrir un shell dans le container : docker exec -ti $NOMCONTAINER bash
        Pour arreter le container : docker stop $NOMCONTAINER
        Pour arrêter définitivement le container (empêcher la relance au reboot) : docker stop $NOMCONTAINER && docker rm $NOMCONTAINER
EOF
