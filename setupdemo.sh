#!/bin/bash

mkdir ~/repos
cd ~/repos
git clone https://github.com/wgoulet/EasyOpenSSLCA.git
git clone https://github.com/wgoulet/BulkVirtualHostCreator.git
cd ~/repos/BulkVirtualHostCreator
chmod +x init.sh
sudo ./init.sh
# Reboot workstation to persist network setting &
# disable NetworkManager
sudo shutdown -r now

