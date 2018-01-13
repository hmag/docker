#!/bin/bash
# Lance un container docker pour démarrer Apache, PHP, ....
docker run -p 80:80 -h "hmapache" -v /var/www/:/var/www -dti hmapache
# -p 80:80 : pour faire correspondre le port 80 du container avec celui du PC qui lance
# -v /var/www:/var/www : pour que ce soit ce répertoire là qui serve de source
# -h "hmapache" : pour donner un nom de host plutôt qu'utiliser l'ID du container comme nom d'hote
CID=`docker ps --latest --quiet`
NCID=`docker ps --latest --format "{{.Names}}"`
echo Container créé : $CID
echo Nom de code : $NCID
cat << EOF
	Pour identifier l'ID du container : docker ps
	Pour ouvrir un shell dans le container : docker exec -ti $NCID bash
	Pour arreter le container : docker stop $NCID
EOF
