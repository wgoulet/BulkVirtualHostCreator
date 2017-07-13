#!/bin/bash

apt-get --yes install nginx

# Create nginx tls directory
mkdir /etc/nginx/tls

# Copy EasyOpenSSLCA to /root directory
cp ~/repos/EasyOpenSSLCA /root
