#!/bin/bash

printf "auto $1\niface $1 inet static\n\taddress 10.10.10.1\n\tnetmask 255.255.255.0\n" >> /etc/network/interfaces

service networking restart

apt-get --yes install nginx

# Create nginx tls directory
mkdir /etc/nginx/tls

cp ./master /etc/nginx/sites-available
rm /etc/nginx/sites-enabled/default

# Copy EasyOpenSSLCA to /root directory
cp -r ~/repos/EasyOpenSSLCA /root
