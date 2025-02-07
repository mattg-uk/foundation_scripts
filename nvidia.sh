#!/bin/bash

. ./utils.sh

# ----------------------------------------------------------------------------------------------------
# Conf iguration of nvidia driver; version is 560
apt install nvidia-dkms-560
apt install nvidia-utils-560
apt install libnvidia-egl-wayland1
apt install libnvidia-gl-560

cp $SCRIPT_DIR/nvidia/modprobe.d/* /etc/modprobe.d 
cp $SCRIPT_DIR/nvidia/initramfs-tools/* /etc/initramfs-tools
update-initramfs -u
    
