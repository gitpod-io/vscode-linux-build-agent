#!/bin/bash

# Script to build musl toolchain
# Usage: ./build-musl-toolchain.sh <tuple> <pkg>
# Example: ./build-musl-toolchain.sh aarch64-linux-musl aarch64-linux-musl-gcc-10.3.0

set -e

# Check if required parameters are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <tuple> <pkg>"
    echo "Example: $0 aarch64-linux-musl aarch64-linux-musl-gcc-10.3.0"
    exit 1
fi

TUPLE="$1"
PKG="$2"

echo "Building musl toolchain for $TUPLE (package: $PKG)"

# Prepare dependencies
echo "Installing dependencies..."
sudo apt-get update
sudo apt-get install -y gcc g++ gperf bison flex texinfo help2man make libncurses5-dev \
    python3-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip \
    patch rsync meson ninja-build git

# Build toolchain
echo "Cloning musl-cross-make..."
git clone https://github.com/richfelker/musl-cross-make/
cd musl-cross-make

echo "Building toolchain for target: $TUPLE"
make TARGET="$TUPLE" GCC_VER=10.3.0 BINUTILS_VER=2.33.1 LINUX_VER=5.8.5 install

# Create pipeline asset
echo "Creating package archive: $PKG.tar.gz"
tar -czf "../$PKG.tar.gz" output

echo "Toolchain build completed successfully!"
echo "Archive created: $PKG.tar.gz"