#!/bin/bash
NOMCONTAINER="hmgogs"
ISCREATED=`docker ps --filter="name=$NOMCONTAINER" -q -a | wc -l`
ISRUNNING=`docker ps --filter="name=$NOMCONTAINER" -q | wc -l`
if [ $ISRUNNING -eq 1 ]; then
	echo "Container $NOMCONTAINER est déjà en cours..."
	docker ps --filter="name=$NOMCONTAINER"
elif [ $ISCREATED -eq 1 ]; then
	echo "Redémarrage du container $NOMCONTAINER"
	docker start $NOMCONTAINER
else
	echo "Lancement du container $NOMCONTAINER à partir de l'image"
	docker run -p 10080:3000 -p 10022:22 -v $HOME/gogs:/data -e TZ='Europe/Paris' -e PUID=$(id $USER -u) -e PGID=$(id $USER -g) --restart=always --name $NOMCONTAINER -dti hmgogs
fi
cat << EOF
	Pour ouvrir un shell dans le container : docker exec -ti $NOMCONTAINER bash
	Pour arreter le container : docker stop $NOMCONTAINER
	Pour arrêter définitivement le container (empêcher la relance au reboot) : docker stop $NOMCONTAINER && docker rm $NOMCONTAINER
EOF
