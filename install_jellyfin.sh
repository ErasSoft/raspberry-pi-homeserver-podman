#!/bin/bash

# Raspberry Pi OS - Installation jellyfin
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026

# steps before start script:
# unmont usb disk
# sudo mkdir -p /mnt/intenso
# id podmanuser
# sudo nano /etc/fstab
# UUID=<UUID> /mnt/intenso vfat defaults,nofail,x-systemd.automount,uid=1002,gid=1002,dmask=0022,fmask=0133 0 0
# sudo systemctl daemon-reload
# sudo mount -a


# load config
source ./config/install_config.sh

# start as podmanuser!
if [ "$(id -u)" -ne "$(id -u $PODMAN_USERNAME)" ]; then
    echo "ERR: This script must be executed as $PODMAN_USERNAME! Use the command: su $PODMAN_USERNAME"
    exit 1
fi

lsblk -f

echo "Create directories... ($JELLYFIN_CONFIG, $JELLYFIN_CACHE)"
mkdir -p "$JELLYFIN_CONFIG" "$JELLYFIN_CACHE"

echo "Create container..."
podman run -d \
 --detach \
 --label "io.containers.autoupdate=registry" \
 --name jellyfin \
 --publish $JELLYFIN_PORT:8096/tcp \
 --publish 7359:7359/udp \
 --user $(id -u):$(id -g) \
 --userns keep-id \
 --volume $JELLYFIN_CONFIG:/config:Z \
 --volume $JELLYFIN_CACHE:/cache:Z \
 --mount type=bind,source=$JELLYFIN_MOUNT_PATH,destination=/media,ro=true,relabel=private \
 --restart=unless-stopped \
 docker.io/jellyfin/jellyfin:latest

echo "Start in browser: $JELLYFIN_URL"
