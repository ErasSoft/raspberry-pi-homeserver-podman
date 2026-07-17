#!/usr/bin/env bash

# Raspberry Pi OS - Installation Homepage Autostart
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

mkdir -p ~/.config/labwc

grep -qxF '(sleep 10; firefox --kiosk http://localhost) &' \
    ~/.config/labwc/autostart 2>/dev/null ||
echo '(sleep 10; firefox --kiosk http://localhost) &' \
    >> ~/.config/labwc/autostart

chmod +x ~/.config/labwc/autostart
