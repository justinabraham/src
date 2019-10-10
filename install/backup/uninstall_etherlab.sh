#!/bin/bash

cd /epics/drivers/ethercat/etherlabmaster-code
sudo make clean

cd /etc/init.d/
sudo update-rc.d -f ethercat remove
sudo rm ethercat

cd /etc/udev/rules.d
sudo rm 99-EtherCAT.rules

# Copy some files #################################################################
sudo rm /bin/ethercat
sudo rm -r /etc/sysconfig/
sudo rm -r /usr/lib/libethercat.*