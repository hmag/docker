#!/bin/bash
ISARM=`arch | grep arm | wc -l`
ISMPD=`grep mpd /etc/passwd | wc -l`
ARCH="amd64"
if [ $ISARM -eq 1 ]; then
        ARCH="armhf"
fi
if [ $ISMPD -eq 0 ]; then
	echo "le user mpd n'existe pas sur le system hote"
	exit 1
fi
MPDUID=`grep mpd /etc/passwd | awk -v FS=":" '{print $3}'`
AUDIOGID=`grep mpd /etc/passwd | awk -v FS=":" '{print $4}'`
# Construire l'image qui s'appellera "hmmpd" à partir du dockerfile présent dans ce répertoire
docker build --rm --build-arg MPDUID=$MPDUID --build-arg AUDIOGID=$AUDIOGID -t hmmpd .
if [ $? -ne 0 ]; then
	# Si le Build échoue, c'est probablement à cause d'un uid déjà utilisé dans le container...
	echo "Echec de la construction du container....."
	echo "Si le compte mpd avec le uid $MPDUID ne peut être créé dans le container"
	echo " il faudra changer le uid sur l'hote via : sudo usermod -u <un UID libre sur le container> mpd"
	echo " >> pour chercher un uid de libre sur le container faire :"
	echo "    docker run -ti <ID du container récupéré avec docker images> cat /etc/passwd"
fi
