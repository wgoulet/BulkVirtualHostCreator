#!/bin/bash

printf "auto eth1\niface eth1 inet static\n\taddress 10.10.10.1\n\tnetmask 255.255.255.0\n" >> /etc/network/interfaces
apt-get --yes install nginx

# Create nginx tls directory
mkdir /etc/nginx/tls

cp ./master /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default

# Copy EasyOpenSSLCA to /root directory
cp -r ~/repos/EasyOpenSSLCA /root