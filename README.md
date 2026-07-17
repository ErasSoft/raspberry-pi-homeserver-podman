# raspberry-pi-homeserver-podman

## Download:

`git clone https://github.com/ErasSoft/raspberry-pi-homeserver-podman`

`cd raspberry-pi-homeserver-podman`

`chmod +x . -R`


## Config:

Change config in folder config!


## Install:

### start as root
sudo ./install_remotedesktop.sh
sudo ./install_raspberry_pi_connect.sh
sudo ./install_podman.sh

### start as podmanuser
./install_podman2.sh
./install_pihole.sh
./install_ftp_server.sh
./install_jellyfin.sh

./install_restart_cronjob.sh


## Podman commands:

podman ps -a

podman start <container-name>

podman stop <container-name>

podman rm <container-name>

### show logs
podman logs <container-name>

### delete not used images
df -h
podman image prune -a
df -h

### Show last system reboot
who -b