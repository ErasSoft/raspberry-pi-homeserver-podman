#!/bin/bash

# Raspberry Pi OS - This script remove sudo from current user and set password for root to change to root user with su - root
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 30.07.2026


# load config
source ./config/install_config.sh

# start as root!
if [ $(id -u) -ne 0 ]; then
  echo "ERR: This script must be run as root."
  exit 1
fi

# change password of root
echo "root:$ROOT_PASSWORD" | sudo chpasswd

# remove the line
visudo -f /etc/sudoers.d/90-cloud-init-users

# remove sudo from current user
sudo gpasswd -d $USER_USERNAME sudo
