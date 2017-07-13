sudo apt-get install git
mkdir ~/repos
cd ~/repos
git clone https://github.com/wgoulet/EasyOpenSSLCA.git
git clone https://github.com/wgoulet/BulkVirtualHostCreator.git
cd ~/repos/BulkVirtualHostCreator
chmod +x init.sh
sudo ./init.sh
# Reboot workstation to persist network setting &
# disable NetworkManager
shutdown -r now
sudo -i
cd /root/EasyOpenSSLCA
make all
exit
cd ~/repos/BulkVirtualHostCreator
sudo python setup_scantarget.py skodemo newdomain.org
sudo nginx

./setupdemo.sh

setupdemo.sh
#!/bin/bash

sudo apt-get install git --yes
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

sudo finishdemo.sh
#!/bin/bash
cd /root/EasyOpenSSLCA
make all
cd ~/repos/BulkVirtualHostCreator
python setup_scantarget.py skodemo newdomain.org
nginx

