#!/bin/bash

set -ex

if [[ $(uname)  == "Linux" ]]; then
    CMAKE_EXE_LINKER_FLAGS_INIT="-lrt"
fi

cmake ${CMAKE_ARGS} -G Ninja -B _build \
    -DELFIO_BUILD_TESTS=on \
    -DCMAKE_EXE_LINKER_FLAGS_INIT="${CMAKE_EXE_LINKER_FLAGS_INIT}"

export VERBOSE=1

cmake --build _build


if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
    (cd _build && ctest)
fi

cmake --install _build
