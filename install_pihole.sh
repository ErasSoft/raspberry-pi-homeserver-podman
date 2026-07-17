#!/bin/bash

# Raspberry Pi OS - Installation pihole
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
    --name pihole \
    -e TZ="Europe/Berlin" \
    -e FTLCONF_webserver_api_password="$PIHOLE_PASSWORD" \
    -e FTLCONF_dns_upstreams="8.8.8.8;8.8.4.4" \
    -p 53:53/tcp -p 53:53/udp \
    -p $PIHOLE_PORT:80 \
    -p 443:443 \
    -v pihole_data:/etc/pihole \
    -v dnsmasq_data:/etc/dnsmasq.d \
    --restart=unless-stopped \
    docker.io/pihole/pihole:latest
