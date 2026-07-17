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

podman run -d \
    --name $FTP_USERNAME \
	--network host \
	--env FTP_USER=$FTP_PASSWORD \
	--env FTP_PASS=$FTP_PASSWORD \
	-v /home/$PODMAN_USERNAME/ftp:/home/$FTP_USERNAME \
	docker.io/garethflowers/ftp-server
