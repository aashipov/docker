#!/bin/bash

set -e

# Download and set all the tools up in /opt
# /opt/openjdk{8,11,17}
# /opt/nodejs16
# /usr/bin/docker-compose (2.6.1)

docker-compose_setup() {
    curl -L -o /usr/bin/docker-compose https://github.com/docker/compose/releases/download/v2.6.1/docker-compose-linux-x86_64
    chmod +x /usr/bin/docker-compose
    docker --version
    docker-compose --version
}

tool_setup() {
    local TOOL_NAME=${1}
    local REMOTE_TAR_GZ=${2}
    local LOCAL_TAR_GZ=/tmp/${TOOL_NAME}.tar.gz
    local TARGET_DIR=/opt/${TOOL_NAME}
    mkdir -p ${TARGET_DIR}
    curl -L -o ${LOCAL_TAR_GZ} ${REMOTE_TAR_GZ}
    tar -xzf ${LOCAL_TAR_GZ} -C ${TARGET_DIR} --strip-components=1
}

clean_openjdk() {
    local DIR_TO_CLEAN=/opt/${1}
    find "${DIR_TO_CLEAN}" -type f -name '*.debuginfo' -exec rm {} \;
    find "${DIR_TO_CLEAN}" -type f -name '*.diz' -exec rm {} \;
    rm -rf ${DIR_TO_CLEAN}/demo/ ${DIR_TO_CLEAN}/lib/src.zip ${DIR_TO_CLEAN}/man/
    ${DIR_TO_CLEAN}/bin/java -version
}

main() {
    cat tools.dsv | while read LINE; do
        if [ ! -z "${LINE}" ]; then
            printf "a line: ${LINE}\n"
            local TOOL_NAME=$(printf "${LINE}\n" | cut -d '|' -f 1)
            local REMOTE_TAR_GZ=$(printf "${LINE}\n" | cut -d '|' -f 2)
            tool_setup ${TOOL_NAME} ${REMOTE_TAR_GZ}
            if [[ "${TOOL_NAME}" == *"jdk"* ]]; then
                clean_openjdk ${TOOL_NAME}
            fi
        fi
    done
    docker-compose_setup
}


# Main procedure
_SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0")")
cd ${_SCRIPT_DIR}

main
