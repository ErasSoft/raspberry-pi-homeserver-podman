#!/usr/bin/env bash

# Raspberry Pi OS - Installation Homepage
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026


# load config
source ./config/install_config.sh

# start as podmanuser
if [ "$(id -un)" != "$PODMAN_USERNAME" ]; then
    echo "ERR: Run as $PODMAN_USERNAME"
    exit 1
fi

echo "Create directory... ($HOMEPAGE_BASE)"
mkdir -p "$HOMEPAGE_BASE"

echo "Create container..."

podman run -d \
    --name homepage \
    --publish 80:3000 \
    --env "HOMEPAGE_ALLOWED_HOSTS=*" \
    --volume "$HOMEPAGE_BASE:/app/config" \
    --restart=unless-stopped \
	--network homeserver \
    --volume "/run/user/$(id -u)/podman/podman.sock:/var/run/docker.sock" \
    ghcr.io/gethomepage/homepage:latest
