#!/bin/bash

ARCH=$(uname -p)

git clone https://github.com/microsoft/vcpkg
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg install colmap[cuda,tests]:x64-linux
