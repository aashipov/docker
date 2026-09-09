#!/bin/sh

# git clone https://github.com/ggml-org/llama.cpp.git
# cd llama.cpp
# git checkout tags/...
# llama-server --threads 8 --host 0.0.0.0 --port 8080

with_cmake() {
    cd ${_SCRIPT_DIR}
    rm -rf ${BUILD_DIR_NAME}
    mkdir ${BUILD_DIR_NAME} && cd ${BUILD_DIR_NAME}
    cmake .. -DCMAKE_INSTALL_PREFIX=${HOME}/.local/ -DBUILD_TESTING=OFF -DGGML_VULKAN=ON
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
}

closure
