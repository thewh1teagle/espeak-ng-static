#!/bin/bash

cd espeak-ng

# Add pthread flags if the platform is Linux
if [[ "$(uname -s)" == "Linux" ]]; then
    EXTRA_CMAKE_ARGS="$EXTRA_CMAKE_ARGS -DCMAKE_C_FLAGS=-pthread -DCMAKE_EXE_LINKER_FLAGS=-pthread"
fi

# Static archive
cmake -B build -DBUILD_SHARED_LIBS=OFF -DENABLE_TESTS=OFF -DCOMPILE_INTONATIONS=OFF -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=_install . $EXTRA_CMAKE_ARGS
cmake --build build --config Release
cmake --install build

# Package for Windows

# Package for Windows
if [[ "$(uname -s)" =~ MINGW|MSYS|CYGWIN ]]; then
    ls _install/bin
    ls _install
    mv _install/bin/espeak-ng.exe ../espeak-ng-static.exe
else
    # Package for Unix
    # cp _static/lib/libespeak-ng.a _dynamic/lib
    # Package the libraries
    chmod +x _install/bin/espeak-ng
    mv _install/bin/espeak-ng ../espeak-ng-static
fi