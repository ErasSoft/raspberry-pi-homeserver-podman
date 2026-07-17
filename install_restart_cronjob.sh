#!/bin/bash

# Raspberry Pi OS - Installation of reboot script
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

REBOOT_CRONJOB_COMMAND="@reboot /home/$PODMAN_USERNAME/start_pods.sh"
(crontab -l 2>/dev/null; echo $REBOOT_CRONJOB_COMMAND) | crontab -

START_PODS_SCRIPT="/home/${PODMAN_USERNAME}/start_pods.sh"

{
    echo '#!/usr/bin/env bash'
    echo
    echo 'set -e'
    echo
    echo "PODMAN_USERNAME=\"${PODMAN_USERNAME}\""
    echo
    echo 'if [ "$(id -u)" -ne "$(id -u "$PODMAN_USERNAME")" ]; then'
    echo '    echo "ERR: This script must be executed as $PODMAN_USERNAME!"'
    echo '    echo "Use: sudo -iu $PODMAN_USERNAME"'
    echo '    exit 1'
    echo 'fi'
    echo
    echo 'podman start pihole'
    echo 'podman start ftpUser'
    echo 'podman start jellyfin'
} > "$START_PODS_SCRIPT"

chmod 750 "$START_PODS_SCRIPT"
chown "$PODMAN_USERNAME:$PODMAN_USERNAME" "$START_PODS_SCRIPT"

echo "Created: $START_PODS_SCRIPT"
