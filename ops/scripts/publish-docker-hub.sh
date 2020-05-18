
set -e
# before you run this you need to run 
# $ source .xrengine-secrets to load tokens and passwords

cd ../xrengine-client

git fetch --tags
TAG="$(git describe --abbrev=0 --tags)"

cd ../xrengine-ops

export NEW_TAG=rc0.0.5
docker-compose -f docker-compose-local.yml build
docker login --username xrengine --password ${DOCKER_HUB_TOKEN}
docker tag xrengine/client xrengine/client:${NEW_TAG}
docker push xrengine/client:${NEW_TAG}

for repo in {client,server,realtime-server}; do
    for tag in {$TAG,latest}; do
        docker tag xrengine/${repo} xrengine/${repo}:${tag}
        docker push xrengine/${repo}:${tag}
    done
done 


# docker tag xrengine/xrengine xrengine/xrengine:latest
# docker push xrengine/xrengine:latest 

# docker tag xrengine/realtime-server xrengine/realtime-server:latest
# docker push xrengine/realtime-server:latest

# docker tag xrengine/client xrengine/client:latest
# docker push xrengine/client:latest
