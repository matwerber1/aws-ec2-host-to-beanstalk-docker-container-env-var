#!/bin/bash

DH_USER=berbs
DH_REPO=eb-ec2-metadata-container
DH_TAG=latest

ROOT_DIR=$(pwd)

# Update the Docker Hub image, if you have access to do so...
(cd src/docker ;
docker build -t $DH_REPO:$DH_TAG . ;
docker tag $DH_REPO:$DH_TAG $DH_USER/$DH_REPO:$DH_TAG ;
docker push $DH_USER/$DH_REPO:$DH_TAG)

(cd bin ; rm deploy.zip ; zip -j -r deploy.zip ../src/*)