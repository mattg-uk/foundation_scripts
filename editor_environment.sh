#!/bin/bash

. ./utils.sh

editor_environment=(
alacritty
neovim
)

for package in ${editor_environment[@]}; do
    install_package $package 
done

# Get neovim configuration from github
if [[ ! -e $USER_HOME/.config/nvim ]]; then
    rm -rf tmp/neovim_config
    su -c 'git clone https://github.com/mattg-uk/neovim_config /tmp/neovim_config' $USER
    mv /tmp/neovim_config $USER_HOME/.config/nvim
else
    echo "Neovim config exists; skipping .config"
fi

# Configure alacritty
if [[ ! -e $USER_HOME/.config/alacritty ]]; then
    cp -r $SCRIPT_DIR/dots/alacritty/ $USER_HOME/.config/
else
    echo "Alacritty config exists; skipping .config"
fi

# Hack font used in this alacritty config
echo "Downloading Hack Nerd fonts..."
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip
if [[ ! -d $USER_HOME/.local/share/fonts ]] ; then
    mkdir -p $USER_HOME/.local/share/fonts
fi
unzip -d $USER_HOME/.local/share/fonts/NerdFonts Hack.zip
rm Hack.zip
su -c 'fc-cache -fv' $USER
