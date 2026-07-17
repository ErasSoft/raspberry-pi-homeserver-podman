#!/bin/bash

# Raspberry Pi OS - Installation ftp server
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

echo "Create directory... ($FTP_BASE)"
mkdir -p "$FTP_BASE"

echo "Create container..."
podman run -d \
    --name ftpUser \
	--network host \
	--env FTP_USER=$FTP_USERNAME \
	--env FTP_PASS=$FTP_PASSWORD \
	--publish 20-21:20-21/tcp \
    --publish 40000-40009:40000-40009/tcp \
	-v $FTP_BASE:/home/$FTP_USERNAME \
	--restart=unless-stopped \
	docker.io/garethflowers/ftp-server
