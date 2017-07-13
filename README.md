BulkVirtualHostCreator
======================

Creates a set of virtual IPs and binds multiple
HTTPS virtual servers to them. Used for setting up
systems that you want to scan using network testing 
tools such as nmap.

Installation
------------
Clone this repo into a directory called 'repos' in
your home directory.

chmod +x setupdemo.sh
chmod +x finishdemo.sh

./setupdemo.sh (enter password when prompted for sudo)

System will reboot after this script is run. When
system is back up, run this command:

sudo ./finishdemo.sh

Tested on Ubuntu 14.0.2 LTS Desktop.
