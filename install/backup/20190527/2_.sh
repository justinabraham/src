#!/bin/bash
# echo Hello World
# Install dependencies ############################################################
sudo apt-get install autoconf libtool check patch build-essential libreadline-gplv2-dev re2c libxml2-dev subversion tmux libncurses5-dev fakeroot kernel-package lshw openssh-server linux-headers-$(uname -r) libxml2-dev libxslt-dev python-dev python-lxml python-libxml2

## Checkout EPICS-EtherCAT archive ################################################
# cd ~
# svn co http://svn.tlabs.ac.za/svn/ethercat/

## Extract archive ################################################################
cd ..
sudo tar -xvzf 20160505_iThemba_LABS_EtherCAT_Debian-8.2.0-amd64.tar.gz -C /
sudo chmod -R 777 /epics/
cd /epics

## Install RT Kernel and reboot ##################################################
#cd /epics/RT_kernel_build
#sudo dpkg -i linux-headers-3.4.69-rt85_1.5.2.etherlab_amd64.deb
#sudo dpkg -i linux-source-3.4.69-rt85_1.5.2.etherlab_all.deb
#sudo dpkg -i linux-image-3.4.69-rt85_1.5.2.etherlab_amd64.deb
#echo "Press [ENTER] if no errors in installing RT Kernel"
#read foo
#sudo grub-mkconfig -o /boot/grub/grub.cfg
#echo "System is about to reboot. Choose 3.4.69-rt85 kernel under Advanced options in the Grub menu on reboot. Press [ENTER] to reboot now."
#read foo
#sudo reboot
