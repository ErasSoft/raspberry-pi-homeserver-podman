#!/bin/bash

# Raspberry Pi OS - Installation with podmanuser
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026


# load config
source ./config/install_config.sh

# start as podmanuser!
if [ "$(id -u)" -ne "$(id -u $PODMAN_USERNAME)" ]; then
    echo "ERR: This script must be executed as $PODMAN_USERNAME! Use the command: su $PODMAN_USERNAME"
    exit 1
fi

### use podman user
mkdir -p /home/$PODMAN_USERNAME/.config/cni/net.d
cp -r /etc/cni/net.d/* /home/$PODMAN_USERNAME/.config/cni/net.d/

### for use podman.socket in portainer
mkdir -p ~/.bashrc.d
echo "export XDG_RUNTIME_DIR=/run/user/$(id -u)" > ~/.bashrc.d/systemd 
source ~/.bashrc.d/systemd

## infos about podman containers
systemctl --user enable --now podman.socket
ls -l "/run/user/$(id -u)/podman/podman.sock"
