#!/bin/sh

database_and_admin_user() {
    set +e
    for database_and_admin_user in ${DATABASE_AND_ADMIN_USER}
    do
        cockroach sql --host=${COMPOSE_PROJECT_NAME}:26257 --database=${COMPOSE_PROJECT_NAME} --certs-dir=/root/certs --echo-sql --execute \
            "CREATE DATABASE ${database_and_admin_user};"
        #cockroach sql --host=${COMPOSE_PROJECT_NAME}:26257 --database=${COMPOSE_PROJECT_NAME} --certs-dir=/root/certs --echo-sql --execute \
        #    "CREATE USER ${database_and_admin_user} WITH PASSWORD '${database_and_admin_user}';"
        cockroach sql --host=${COMPOSE_PROJECT_NAME}:26257 --database=${COMPOSE_PROJECT_NAME} --certs-dir=/root/certs --echo-sql --execute \
            "ALTER USER ${database_and_admin_user} WITH PASSWORD '${database_and_admin_user}';"
        cockroach sql --host=${COMPOSE_PROJECT_NAME}:26257 --database=${COMPOSE_PROJECT_NAME} --certs-dir=/root/certs --echo-sql --execute \
            "GRANT ALL ON DATABASE ${database_and_admin_user} TO ${database_and_admin_user};"
        cockroach sql --host=${COMPOSE_PROJECT_NAME}:26257 --database=${COMPOSE_PROJECT_NAME} --certs-dir=/root/certs --echo-sql --execute \
            "GRANT admin TO ${database_and_admin_user};"
    done
    set -e
}

set_up() {
    sleep 10s
    printf "from set_up\n"
    #cockroach init --certs-dir=/root/certs --host=${COMPOSE_PROJECT_NAME}
    database_and_admin_user
}

initialize() {
    local CA_KEY_FILE=/root/ca-key/ca.key
    if [ ! -f ${CA_KEY_FILE} ]
    then
        cockroach cert create-ca --certs-dir=/root/certs --ca-key=${CA_KEY_FILE} --allow-ca-key-reuse
        cockroach cert create-client root --certs-dir=/root/certs --ca-key=${CA_KEY_FILE}
        cockroach cert create-client ${POSTGRES} --certs-dir=/root/certs --ca-key=${CA_KEY_FILE}
        cockroach cert create-node ${POSTGRES} ${COMPOSE_PROJECT_NAME} localhost 0.0.0.0 --certs-dir=/root/certs --ca-key=${CA_KEY_FILE}
        set_up &
    fi
    touch ${INITIALIZED_FILE}
}

closure() {
    # https://stackoverflow.com/a/1482133
    local _SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0")")
    cd ${_SCRIPT_DIR}
    set -e

    local DATABASE_AND_ADMIN_USER="postgres another"

    local INITIALIZED_FILE="/initialized"
    if [ ! -f ${INITIALIZED_FILE} ]
    then
        initialize
    fi
    cockroach start --store=${COMPOSE_PROJECT_NAME} --certs-dir=/root/certs --listen-addr=${COMPOSE_PROJECT_NAME}:26257 --http-addr=${COMPOSE_PROJECT_NAME}:8080 --join=${COMPOSE_PROJECT_NAME}:26257
}

closure
