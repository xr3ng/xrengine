#!/bin/bash
set -e
set -x

STAGE=$1
TAG=$2

docker build --tag xrengine/server .
echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker tag xrengine/server xrengine/server:${STAGE}
docker push xrengine/server:${STAGE}

docker tag xrengine/server xrengine/server:${TAG}
docker push xrengine/server:${TAG}
