#!/bin/sh

IMAGE_NAME=swarmnyc/teamcity-agent-kurento
IMAGE_VERSION=latest

docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .
echo "### Need to do docker login before push to Docker Hub ###"
docker login
docker push ${IMAGE_NAME}:${IMAGE_VERSION}
