#!/bin/sh

IMAGE_NAME=swarmnyc/http2https
IMAGE_VERSION=latest

docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} .
docker login
docker push ${IMAGE_NAME}:${IMAGE_VERSION}

