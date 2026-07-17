#!/bin/bash

# Raspberry Pi OS - Installation podman
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026


# load config
source ./config/install_config.sh

# start as root!
if [ $(id -u) -ne 0 ]; then
  echo "ERR: This script must be run as root."
  exit 1
fi

### podman installation
sudo apt-get -y install podman
podman --version

### create podman user
sudo useradd -m $PODMAN_USERNAME
sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $PODMAN_USERNAME
# change shell of podmanuser
sudo chsh -s /bin/bash $PODMAN_USERNAME
# change password of podmanuser
echo "$PODMAN_USERNAME:$PODMAN_PASSWORD" | sudo chpasswd

# set minimum port to 53 - needed for pihole!
grep -qxF "net.ipv4.ip_unprivileged_port_start=53" /etc/sysctl.conf || echo "net.ipv4.ip_unprivileged_port_start=53" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# enable start after reboot host
loginctl enable-linger $PODMAN_USERNAME
systemctl --user enable --now podman-restart.service
systemctl --user status podman-restart.service

### not allow ssh connection
DONT_ALLOW_SSH_COMMAND="DenyUsers $PODMAN_USERNAME"
grep -qxF "$DONT_ALLOW_SSH_COMMAND" /etc/ssh/sshd_config || echo "$DONT_ALLOW_SSH_COMMAND" | sudo tee -a /etc/ssh/sshd_config
sudo sshd -t && sudo systemctl restart ssh.service

### use podman user
echo "Login with $PODMAN_USERNAME and start the next script! Use the command: su $PODMAN_USERNAME"
