#!/bin/sh

with_cmake() {
    cd ${_SCRIPT_DIR}
    rm -rf ${_SCRIPT_DIR}/${BUILD_DIR_NAME}
    mkdir ${_SCRIPT_DIR}/${BUILD_DIR_NAME} && cd ${_SCRIPT_DIR}/${BUILD_DIR_NAME}
    cmake .. -DCMAKE_INSTALL_PREFIX=${HOME}/.local/ -DOLLAMA_LLAMA_BACKENDS="vulkan"
    make -j8
    make install
}

closure() {
    # https://stackoverflow.com/a/1482133
    # Consistent across Linux bash, Cygwin terminal and Git Bash
    local _SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0")")
    
    # Comment following line out for debug
    export CMAKE_BUILD_TYPE=Release
    local BUILD_DIR_NAME="build"
    
    with_cmake

    cd ${_SCRIPT_DIR}
    go build
    cp ollama $HOME/.local/bin/
}

closure
