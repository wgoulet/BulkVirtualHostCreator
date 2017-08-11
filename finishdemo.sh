#!/bin/bash
cd /root/EasyOpenSSLCA
make all
cd ~/repos/BulkVirtualHostCreator
python setup_scantarget.py scandemo newdomain.org 30
nginx
