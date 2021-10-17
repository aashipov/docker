#!/bin/bash

# Build image

function usage {
    echo "usage: $(basename $0) distro flavor"
    echo "  distro - centos"
    echo "  flavor - dummy jdk11u"
    exit 1
}

if [ $# -ne 2 ]; then
    usage
fi

DISTRO=${1}
FLAVOR=${2}
DOCKER_HUB_USER_AND_REPOSITORY="aashipov/docker"

TAG="${DISTRO}${FLAVOR}"
IMAGE="${DOCKER_HUB_USER_AND_REPOSITORY}:${TAG}"

docker stop ${TAG}
docker rm ${TAG}
docker pull ${IMAGE}
if [[ $? -ne 0 ]]
then 
    docker build --file=Dockerfile.${DISTRO}.${FLAVOR} --tag ${IMAGE} .
    docker push ${IMAGE}
fi