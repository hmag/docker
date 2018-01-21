#!/bin/bash
# Les modes de création de l'image docker sont différents pour ARM et X64:
# on récupère le binaire et on a besoin de connaitre l'architecture pour
# prendre le bon ....
REPTEMP="$HOME/tmp/dockergitea"
GITEAREL="1.3.2"
DOWNLOADBINSITE="https://github.com/go-gitea/gitea/releases/download/"
mkdir -p $REPTEMP
# Récupérer le contenu de ce qu'il faut pour créer le container :
cd $REPTEMP
# Récuperer les sources pour avoir les fichiers à copier dans le container
wget https://github.com/go-gitea/gitea/archive/v$GITEAREL.zip
unzip v$GITEAREL.zip
rm v$GITEAREL.zip
cd gitea-$GITEAREL
case "`arch`" in
	x86_64 | amd64) FICHIER=amd64 ;;
	armv7l) FICHIER=arm-7 ;;
	*) echo "Architecture `arch` inconnue... Sortie"
		exit 1 ;;
esac
FICHIER=gitea-$GITEAREL-linux-$FICHIER

DOWNLOADBIN="$DOWNLOADBINSITE"v"$GITEAREL"/"$FICHIER"
echo "Téléchargement du binaire : $DOWNLOADBIN"
wget -O gitea $DOWNLOADBIN
chmod a+x gitea
# On demande à docker de créer l'image :
docker build --rm -t hmgitea .
echo "Des fichiers temporaires restent dans $REPTEMP : penser à les supprimer"
echo "via : rm -rf $REPTEMP"
cat << EOF
# pour activer dans gitea la recherche dans le code, il faut ajouter les
# lignes ci-dessous dans le fichier gitea/conf/app.ini

[indexer]
ISSUE_INDEXER_PATH = indexers/issues.bleve
; repo indexer by default disabled, since it uses a lot of disk space
REPO_INDEXER_ENABLED = true
REPO_INDEXER_PATH = indexers/repos.bleve
UPDATE_BUFFER_LEN = 20
MAX_FILE_SIZE = 1048576
EOF

