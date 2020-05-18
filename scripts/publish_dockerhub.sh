#!/bin/bash
set -e
set -x

STAGE=$1
TAG=$2

docker build --tag xrengine/xrengine .
echo "$DOCKER_HUB_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker tag xrengine/xrengine xrengine/xrengine:${STAGE}
docker push xrengine/xrengine:${STAGE}

docker tag xrengine/xrengine xrengine/xrengine:${TAG}
docker push xrengine/xrengine:${TAG}
