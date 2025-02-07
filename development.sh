#!/bin/bash

# Run through everything

# Toolchains and essential folders that may not be present on a raw install
# Includes updates to .bashrc if required, which is sourced.
. ./basic_system.sh

# Alacritty and Neovim - everything needed for C/C++ development
./editor_environment.sh

# A Tiling wayland compositor - but the bulk of the installation and dependencies
# are for hyprpanel. If this is onerous, comment it out.
./install_hyprland.sh

