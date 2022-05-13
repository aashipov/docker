#!/bin/bash

# Read tools.dsv, build & publish docker images

main() {
    local DOCKER_HUB_USER_AND_REPOSITORY="aashipov/docker"
    cat tools.dsv | while read LINE; do
        local IMPLEMENTATION=$(printf "${LINE}\n" | cut -d '|' -f 1)
        local TOOL_FLAVOR=$(printf "${LINE}\n" | cut -d '|' -f 2)
        local TOOL_TAG=$(printf "${LINE}\n" | cut -d '|' -f 3)
        local DISTRO=$(printf "${LINE}\n" | cut -d '|' -f 4)
        local JDK_TAR_GZ_URL=$(printf "${LINE}\n" | cut -d '|' -f 5)

        if curl --output /dev/null --silent --head --fail "${JDK_TAR_GZ_URL}"; then
            local TAG=${IMPLEMENTATION}-${TOOL_FLAVOR}-${TOOL_TAG}-${DISTRO}
            # + character is not allowed in docker tag, replace with -
            TAG=${TAG//+/-}
            local IMAGE="${DOCKER_HUB_USER_AND_REPOSITORY}:${TAG}"
            docker pull ${IMAGE}
            if [[ $? -ne 0 ]]; then
                docker stop ${TAG}
                docker rm ${TAG}
                docker build --file=Dockerfile.${DISTRO} --tag ${IMAGE} --build-arg JDK_TAR_GZ_URL=${JDK_TAR_GZ_URL} .
                docker push ${IMAGE}
            else
                printf "Image ${IMAGE} exists at Docker Hub, skip build & push\n"
            fi
        else
            printf "No such JDK_TAR_GZ_URL: ${JDK_TAR_GZ_URL} or line is empty / comment\n"
        fi
    done
}

_SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0")")
cd ${_SCRIPT_DIR}

main
