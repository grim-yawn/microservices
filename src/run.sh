#!/bin/bash
set -euox pipefail
IFS=$'\n\t'

# Enable docker host
eval $(docker-machine env docker-host)

# File with secret vars
source ./secrets.sh

# Pull mongo image
docker pull mongo:latest

# Build images
docker build -t "${BASE_NAME}/post:1.0" ./post-py
docker build -t "${BASE_NAME}/comment:1.0" ./comment
docker build -t "${BASE_NAME}/ui:1.0" ./ui

# Create network if not exists
NETWORK=reddit
if ! docker network ls | grep "${NETWORK}" > /dev/null; then
    docker network create "${NETWORK}"
fi

# Create volume for mongo
VOLUME=reddit_db
if ! docker volume ls | grep "${VOLUME}" > /dev/null; then
    docker volume create "${VOLUME}"
fi

# Stop containers
docker kill $(docker ps -q) || true

# Run containers
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v "${VOLUME}:/data/db" mongo:latest
docker run -d --network=reddit --network-alias=post "${BASE_NAME}/post:1.0"
docker run -d --network=reddit --network-alias=comment "${BASE_NAME}/comment:1.0"
docker run -d --network=reddit -p 9292:9292 "${BASE_NAME}/ui:1.0"
