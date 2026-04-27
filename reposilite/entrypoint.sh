#!/bin/sh

closure() {
    local REPOSILITE_WORK_DIR=${REPOSILITE_WORK_DIR:-${HOME}/reposilite/}
    if [ ! -d ${REPOSILITE_WORK_DIR} ]
    then
        mkdir -p ${REPOSILITE_WORK_DIR}
    fi
    java -Xmx${REPOSILITE_XMX:-128m} -jar reposilite*.jar --port ${REPOSILITE_PORT:-8088} --working-directory ${REPOSILITE_WORK_DIR} --token ${REPOSILITE_TOKEN:-admin:admin}
}

closure
