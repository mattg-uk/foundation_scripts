#!/bin/bash

. ./utils.sh

# ----------------------------------------------------------------------------------------------------
# ASTAL 
astal_ags_dependencies=(
gjs
libjson-glib-1.0-0
libjson-glib-1.0-common
libjson-glib-dev
libgjs-dev 
libpulse-dev
network-manager-dev
libgnome-bluetooth-3.0-dev
libsoup-3.0-dev
gobject-introspection 
libgirepository1.0-dev
libgtk-3-dev
libdbusmenu-gtk3-dev
libgtk-layer-shell-dev
libgtk4-layer-shell-dev
libgtk-4-1
libgtk-4-dev
valac
valadoc
libwireplumber-0.5-dev
libnm-dev
libiniparser-dev
libiniparser1
libfftw3-bin
libfftw3-dev
libjack-jackd2-dev
libsndio-dev
libsdl2-dev
portaudio19-dev
cava
libpam0g-dev
)

for dep in ${astal_ags_dependencies[@]}; do
    install_package $dep
done

# The astal/lib/tray library also has a dependency from the AUR
rm -rf $SCRIPT_DIR/appmenu-glib-translator-git
su -c "git clone https://aur.archlinux.org/appmenu-glib-translator-git.git $SCRIPT_DIR/appmenu-glib-translator-git" $USER
cd $SCRIPT_DIR/appmenu-glib-translator-git
su -c 'makepkg -d' $USER
pacman -U *.gz --assume-installed glib2 --no-confirm

# Pull source for astal-io, astal-gtk3, astal-gtk4; compile
rm -rf $SCRIPT_DIR/astal
su -c "git clone https://github.com/aylur/astal.git $SCRIPT_DIR/astal" $USER

# Meson build the Astal libraries
meson_libs=(
astal/lang/gjs
astal/lib/apps
astal/lib/astal/io
astal/lib/astal/gtk3
astal/lib/astal/gtk4
astal/lib/auth
astal/lib/battery
astal/lib/bluetooth
astal/lib/cava
astal/lib/greet
astal/lib/hyprland
astal/lib/mpris
astal/lib/network
astal/lib/notifd
astal/lib/powerprofiles
astal/lib/tray
)

for pkg in ${meson_libs[@]}; do
    cd $SCRIPT_DIR/$pkg
    meson setup --prefix /usr build
    meson install -C build
done

# ----------------------------------------------------------------------------------------------------
# AGS is a separate repo to Astal
# these instructions supercede the meson build instructions
rm -rf $SCRIPT_DIR/ags
su -c "git clone https://github.com/aylur/ags.git $SCRIPT_DIR/ags" $USER

cd $SCRIPT_DIR/ags

if [[ ! -d $USER_HOME/.local/bin ]]; then
    su -c 'mkdir -p $USER_HOME/.local/bin' $USER
fi

go install -ldflags "\
    -X 'main.gtk4LayerShell=$(pkg-config --variable=libdir gtk4-layer-shell-0)/libgtk4-layer-shell.so' \
    -X 'main.astalGjs=$(pkg-config --variable=srcdir astal-gjs)'"

mv ~/go/bin/ags /usr/local/bin/
