#!/bin/bash

. ./utils.sh

apt update
apt upgrade

basic_deps=(
build-essential
gdb
clangd
lldb
cmake
git
bear
node-typescript
npm
rustup
meson 
golang-go
automake
autoconf
libtool
pacman
makepkg
pacman-package-manager
archlinux-keyring
libarchive-tools
python3-venv
)

# Ubuntu deps
for package in ${basic_deps[@]}; do
    install_package $package
done

su -c 'rustup default stable' $USER
su -c 'rustup update' $USER

