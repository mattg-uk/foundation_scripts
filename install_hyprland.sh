#!/bin/bash

. ./utils.sh

# -------------------------------------------------------------------------------------------------------
# HYPRLAND --------------------------------------------------------------------------------------------
# Hyprland core Ubuntu installation - everything available in KUbuntu 24.10
ubuntu_hyprland=(
hyprcursor-util
hyprland-backgrounds
hyprland-dev
hyprland-protocols
hyprland
hyprwayland-scanner
libhyprcursor-dev
libhyprcursor0
libhyprlang-dev
libhyprlang2
libhyprutils-dev
libhyprutils0
)

for pack in ${ubuntu_hyprland[@]}; do
    install_package $pack
done

# -------------------------------------------------------------------------------------------------------
# HYPRPANEL (bar / tray / notifications / etc ) -------------------------------------------------------
# 1) most deps are available directly from Ubuntu
# 2) dart is available from google via package, but the repo must be added to sources.list.d
# 3) ags will have to have its deps installed and be built from source (separate script)
# 4) clone and build hyprpanel itself
#
hyprpanel_deps=(
wireplumber
libgtop-2.0-11
bluez
network-manager
wl-clipboard
upower
gvfs
gir1.2-gtop-2.0
brightnessctl
liblz4-dev
)

# First the Ubuntu deps -------------------------------------------------------------------------------
for pack in ${hyprpanel_deps[@]}; do
    install_package $pack
done

# Dart Sass & Dart ------------------------------------------------------------------------------------
npm install -g sass
npm install -g gtop

if $(dpkg-query -l dart); then
    # if installed or uninstalled: check / install 
    install_package dart
else
    # if not installed: check transport and sources.list.d
    install_package apt-transport-https
    if [[ ! -e /etc/apt/sources.list.d/dart_stable.list ]]; then
        wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub \
            | sudo gpg  --dearmor -o /usr/share/keyrings/dart.gpg
        echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' \
            | sudo tee /etc/apt/sources.list.d/dart_stable.list
    else
        echo "dart_stable.list already configured."
    fi
    install_package dart
fi

# Install script to build astal and ags ---------------------------------------------------------------
#   (There is a large amount of astal specific dependencies and from-source building in this script)
./install_ags.sh

# Hyprpanel itself ------------------------------------------------------------------------------------
rm -rf /tmp/hyprpanel
su -c "git clone https://github.com/Jas-SinghFSU/HyprPanel.git /tmp/hyprpanel" $USER
cd /tmp/hyprpanel

meson setup build
meson compile -C build
meson install -C build

# Hyprpanel jetbrains fonts
cd /usr/share/hyprpanel/
bash scripts/install_fonts.sh

# Python runtime dependencies used by hyprpanel
pipx install matugen
pipx install pywal

# -------------------------------------------------------------------------------------------------------
# SWWW (Wallpaper) ------------------------------------------------------------------------------------ 
# swww is a rust dependency
su -c 'rustup update' $USER
rm -rf /tmp/swww
su -c "git clone https://github.com/LGFae/swww.git /tmp/swww" $USER
cd /tmp/swww

su -c 'cargo build --release' $USER

if [[ ! -d $USER_HOME/.local/bin ]]; then
    su -c 'mkdir -p $USER_HOME/.local/bin' $USER
fi
mv target/release/swww ~/.local/bin
mv target/release/swww-daemon ~/.local/bin

su -c "cp -r $SCRIPT_DIR/dots/hypr $USER_HOME/.config"
su -c "cp -r $SCRIPT_DIR/dots/hyprpanel $USER_HOME/.config"
