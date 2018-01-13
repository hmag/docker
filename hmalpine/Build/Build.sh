#!/bin/bash
ISARM=`arch | grep arm | wc -l`
ARCH="amd64"
if [ $ISARM -eq 1 ]; then
        ARCH="armhf"
fi
docker build --rm --build-arg ARCH=$ARCH -t hmalpine .
# Construire l'image qui s'appellera "hmalpine" à partir du dockerfile présent dans ce répertoire
