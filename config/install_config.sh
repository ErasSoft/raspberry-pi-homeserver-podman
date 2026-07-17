#!/bin/bash

# Raspberry Pi OS - Configs
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026


# Username of Remotedesktop
# script: install_remotedesktop.sh
REMOTE_USERNAME="remoteUser"
REMOTE_PASSWORD="password"

ADMIN_USERNAME="pi"
ADMIN_PASSWORD="raspberry"

PODMAN_USERNAME="podmanuser"
PODMAN_PASSWORD="password"

PIHOLE_PASSWORD="password"
PIHOLE_PORT="8081"

FTP_USERNAME="ftpUser"
FTP_PASSWORD="password"

JELLYFIN_BASE="/home/$PODMAN_USERNAME/jellyfin"
JELLYFIN_CONFIG="$JELLYFIN_BASE/config"
JELLYFIN_CACHE="$JELLYFIN_BASE/cache"

JELLYFIN_MOUNT_PATH="/mnt/intenso"
JELLYFIN_PORT="8899"
JELLYFIN_URL="http://127.0.0.1:$JELLYFIN_PORT"

JELLYFIN_USERNAME="jellyfin"
JELLYFIN_PASSWORD="password"

JELLYFIN_SERVER_NAME="RaspberryPiJellyfin"
