#!/bin/bash

# Raspberry Pi OS - Configs
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026


# Username of Remotedesktop
# script: install_remotedesktop.sh
REMOTE_USERNAME="remoteUser"
REMOTE_PASSWORD="password"

# script: install_podman.sh
PODMAN_USERNAME="podmanuser"
PODMAN_PASSWORD="password"

# script: install_pihole.sh
PIHOLE_PASSWORD="password"
PIHOLE_PORT="8081"

# script: install_ftp_server.sh
FTP_BASE="/home/$PODMAN_USERNAME/ftp"
FTP_USERNAME="ftpUser"
FTP_PASSWORD="password"

# script: install_jellyfin.sh
JELLYFIN_BASE="/home/$PODMAN_USERNAME/jellyfin"
JELLYFIN_CONFIG="$JELLYFIN_BASE/config"
JELLYFIN_CACHE="$JELLYFIN_BASE/cache"

JELLYFIN_MOUNT_PATH="/mnt/intenso"
JELLYFIN_PORT="8899"
JELLYFIN_URL="http://127.0.0.1:$JELLYFIN_PORT"

JELLYFIN_USERNAME="jellyfinUser"
JELLYFIN_PASSWORD="password"

JELLYFIN_SERVER_NAME="Jellyfin - Raspberry Pi"

# Login -> Administration -> Dashboard -> Advanced -> API-Key
JELLYFIN_API_KEY=""

# script: install_homepage.sh
HOMEPAGE_BASE="/home/$PODMAN_USERNAME/homepage"
