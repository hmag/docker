#!/bin/bash
# Les modes de création de l'image docker sont différents pour ARM et X64:
## pour x64 il suffit de récupérer l'image
## pour ARM, il faut la construire...
ISARM=`arch | grep arm | wc -l`
REPTEMP="$HOME/tmp/dockergogs"
mkdir -p $REPTEMP
# Récupérer le contenu de ce qu'il faut pour créer le container :
cd $REPTEMP
wget https://github.com/gogits/gogs/archive/master.zip
unzip master.zip
cd gogs-master
if [ $ISARM -eq 1 ]; then
	# On prend le Dockerfile qui correspond au raspberry pi:
	mv Dockerfile.rpi Dockerfile
	# Changement du miroir de la version edge, le miroir 2 semble HS :
	sed -i 's/dl-2/dl-3/g' Dockerfile
fi
# On demande à docker de créer l'image :
docker build --rm -t hmgogs .
echo "Des fichiers temporaires restent dans $REPTEMP : penser à les supprimer"
echo "via : rm -rf $REPTEMP"
