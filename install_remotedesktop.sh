#!/bin/bash

# Raspberry Pi OS - Installation to use Remotedesktop
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026


# start as root!
if [ $(id -u) -ne 0 ]; then
  echo "ERR: This script must be run as root."
  exit 1
fi

# load config
source ./config/install_config.sh

# install packages
sudo apt-get install xrdp

# create user to login via remotedesktop
sudo adduser ${$REMOTE_USERNAME}
sudo usermod -aG sudo ${$REMOTE_USERNAME}
