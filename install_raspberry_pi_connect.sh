#!/bin/bash

# Raspberry Pi OS - Installation of Raspberry Pi Connect
# os: Debian GNU/Linux 13 (trixie)
# author: Tino Schuldt
# date: 17.07.2026

# more information: https://www.raspberrypi.com/documentation/services/connect.html


# start as root!
if [ $(id -u) -ne 0 ]; then
  echo "ERR: This script must be run as root."
  exit 1
fi

rpi-connect signin
