#!/bin/bash

mkdir ~/repos
cd ~/repos
git clone https://github.com/wgoulet/EasyOpenSSLCA.git
git clone https://github.com/wgoulet/BulkVirtualHostCreator.git
cd ~/repos/BulkVirtualHostCreator
sudo ./init.sh $1
# Reboot workstation to persist network setting &
# disable NetworkManager
echo "Restarting system in 5 seconds; when system is back up execute ./finishdemo.sh"
sleep 5
sudo shutdown -r now

