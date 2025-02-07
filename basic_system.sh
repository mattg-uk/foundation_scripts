#!/bin/bash

. ./utils.sh

apt update
apt upgrade --assume-yes

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

# Make the folders, update the path and ensure its SOURCED
if [[ ! -d $USER_HOME/.local/bin ]]; then
    su -c "mkdir -p $USER_HOME/.local/bin" $USER
fi

if [[ ! -d $USER_HOME/.local/share/fonts ]] ; then
    mkdir -p $USER_HOME/.local/share/fonts
fi

if ! grep local/bin $USER_HOME/.bashrc; then
    echo "export PATH=$PATH:$USER_HOME/.local/bin" >> $USER_HOME/.bashrc
    . $USER_HOME/.bashrc
fi

