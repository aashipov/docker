#!/bin/sh

closure() {
    # https://stackoverflow.com/a/1482133
    # Consistent across Linux bash, Cygwin terminal and Git Bash
    local _SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0")")
    local EXECUTABLE_NAME=kilo
    
    cd ${_SCRIPT_DIR}
    bun install
    ./packages/opencode/script/build.ts --single
    cp packages/opencode/dist/@kilocode/cli-linux-x64/bin/${EXECUTABLE_NAME} ${HOME}/.local/bin/
}

closure
