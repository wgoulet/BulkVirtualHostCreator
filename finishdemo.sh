#!/bin/bash
cd /root/EasyOpenSSLCA
make all
cd ~/repos/BulkVirtualHostCreator
python setup_scantarget.py skodemo newdomain.org
nginx
