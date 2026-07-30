#!/bin/bash

# Raspberry Pi OS - Installation of reboot script
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026


# load config
source ./config/install_config.sh

# start as podmanuser!
if [ "$(id -u)" -ne "$(id -u $PODMAN_USERNAME)" ]; then
    echo "ERR: This script must be executed as $PODMAN_USERNAME! Use the command: su - $PODMAN_USERNAME"
    exit 1
fi

mkdir -p ~/.config/systemd/user
nano ~/.config/systemd/user/start-pods.service

{
    echo '[Unit]'
    echo 'Description=Rootless Podman-Container starten'
    echo
    echo '[Service]'
    echo 'Type=oneshot'
    echo 'ExecStart=/bin/bash /home/podmanuser/start_pods.sh'
    echo 'RemainAfterExit=yes'
    echo 'Restart=on-failure'
    echo 'RestartSec=10'
    echo
    echo '[Install]'
    echo 'WantedBy=default.target'
} > "$START_PODS_SCRIPT"


systemctl --user daemon-reload
systemctl --user enable --now start-pods.service

systemctl --user status start-pods.service --no-pager

echo "Created: $START_PODS_SCRIPT"
