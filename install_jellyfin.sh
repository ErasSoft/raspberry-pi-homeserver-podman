#!/bin/bash

# Raspberry Pi OS - Installation jellyfin
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

podman run \
 --detach \
 --label "io.containers.autoupdate=registry" \
 --name jellyfin \
 --publish $JELLYFIN_PORT:8096/tcp \
 --publish 7359:7359/udp \
 --rm \
 --user $(id -u):$(id -g) \
 --userns keep-id \
 --volume jellyfin-cache:/cache:Z \
 --volume jellyfin-config:/config:Z \
 --mount type=bind,source=/path/to/media,destination=/media,ro=true,relabel=private \
 docker.io/jellyfin/jellyfin:latest