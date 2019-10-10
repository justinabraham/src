#!/bin/bash

## Extract archive ################################################################
sudo tar -xvzf ../20191009_TLABS_ECAT_Debian-10.1.0-rt-amd64-netinst.tar.gz -C /
sudo chmod -R 777 /epics/
cd /epics
ls -la