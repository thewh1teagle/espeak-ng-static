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
mv _install espeak-ng-static

# Show package contents
echo "Package Contents:"
echo "================="
tree espeak-ng-static 2>/dev/null || echo "Unable to display contents. Make sure the 'tree' command is installed."

# Create the tarball
tar -czf espeak-ng-static.tar.gz espeak-ng-static
echo "espeak-ng-static.tar.gz created"