#!/bin/sh

closure() {
    local CMD_LINE_BUILDER="java"
    
    if [ -n "${REPOSILITE_XMX}" ]
    then
        CMD_LINE_BUILDER="${CMD_LINE_BUILDER} -Xmx${REPOSILITE_XMX}"
    fi

    CMD_LINE_BUILDER="${CMD_LINE_BUILDER} -jar reposilite*.jar"
    
    if [ -n "${REPOSILITE_PORT}" ]
    then
        CMD_LINE_BUILDER="${CMD_LINE_BUILDER} --port ${REPOSILITE_PORT}"
    fi

    if [ -n "${REPOSILITE_WORK_DIR}" ]
    then
        CMD_LINE_BUILDER="${CMD_LINE_BUILDER} --working-directory ${REPOSILITE_WORK_DIR}"
        mkdir -p ${REPOSILITE_WORK_DIR}
    fi

    if [ -n "${REPOSILITE_TOKEN}" ]
    then
        CMD_LINE_BUILDER="${CMD_LINE_BUILDER} --token ${REPOSILITE_TOKEN}"
    fi

    if [ -n "${REPOSILITE_DB}" ]
    then
        CMD_LINE_BUILDER="${CMD_LINE_BUILDER} --database \"${REPOSILITE_DB}\""
    fi
    
    eval ${CMD_LINE_BUILDER}
}

closure
