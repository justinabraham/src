#!/bin/bash
# echo Hello World
# Install dependencies ############################################################
#sudo apt-get install autoconf libtool check patch build-essential libreadline-gplv2-dev re2c libxml2-dev subversion tmux libncurses5-dev fakeroot kernel-package lshw

## Checkout EPICS-EtherCAT archive ################################################
# cd ~
# svn co http://svn.tlabs.ac.za/svn/ethercat/

## Extract archive ################################################################
# cd ethercat/
# sudo tar -xvzf 20160505_iThemba_LABS_EtherCAT_Debian-8.2.0-amd64.tar.gz -C /
# sudo chmod -R 777 /epics/
# cd /epics

## Install RT Kernel and reboot ##################################################
#cd /epics/RT_kernel_build
#sudo dpkg -i linux-headers-3.4.69-rt85_1.5.2.etherlab_amd64.deb
#sudo dpkg -i linux-source-3.4.69-rt85_1.5.2.etherlab_all.deb
#sudo dpkg -i linux-image-3.4.69-rt85_1.5.2.etherlab_amd64.deb
#sudo grub-mkconfig -o /boot/grub/grub.cfg
#sudo reboot

# Install new e1000e driver ######################################################
# cd ~/ethercat
# cp e1000e-3.3.3.tar ../
# cd ..
# tar -xvf e1000e-3.3.3.tar
# cd e1000e-3.3.3/src/
# make clean
# make
# sudo make install
# sudo cp e1000e.ko /lib/modules/3.4.69-rt85/kernel/drivers/net/ethernet/intel/e1000e/
# cd /lib/modules/3.4.69-rt85/kernel/drivers/net/ethernet/intel/e1000e/
# sudo rmmod e1000e.ko
# sudo modprobe e1000e
# cd ~
# sudo rm -r e1000e-3.3.3
# rm e1000e-3.3.3.tar

# Update initramfs image #########################################################
# sudo update-initramfs -v -u -k `uname -r`
# sudo reboot

# Make base and support ##########################################################
cd /epics/base
sudo make
cd /epics/support/
sudo make
echo "Press [ENTER] if no errors in make of EPICS base and support"
read foo

# Install etherlabs driver #######################################################
cd /epics/drivers/ethercat/etherlabmaster-code
sudo ./configure --enable-e1000e --disable-r8169 --disable-8139too --prefix=/epics/drivers/ethercat/etherlabmaster-code/sysroot
make clean
make
make all modules
sudo make install
sudo make modules_install
echo "Press [ENTER] if no errors in make and install of etherlabs driver"
read foo

# EtherCAT app start automatically ###############################################
sudo ln -s /epics/drivers/ethercat/etherlabmaster-code/sysroot/etc/init.d/ethercat /etc/init.d/ethercat
cd /etc/init.d/
sudo update-rc.d ethercat defaults

# Create a blank 99-EtherCAT.rules file ##########################################
cd /etc/udev/rules.d
echo "KERNEL==\"EtherCAT[0-9]*\", MODE=\"0664\"" | sudo tee --append 99-EtherCAT.rules

# Add EtherCAT network card address ##############################################
# First file #####################################################################
cd /epics/drivers/ethercat/etherlabmaster-code/sysroot/etc/
echo "Enter MAC address of EtherCAT linked NIC (XX:XX:XX:XX:XX:XX), followed by [ENTER]:"
read MAC_ADD
MAC_STR="MASTER0_DEVICE="
MAC_STR="$MAC_STR\"$MAC_ADD\""
sed -i '25s/.*/'"$MAC_STR"'/' ethercat.conf
sed -i '45s/.*/DEVICE_MODULES="generic"/' ethercat.conf
# Second file ####################################################################
cd /epics/drivers/ethercat/etherlabmaster-code/sysroot/etc/sysconfig
sed -i '27s/.*/'"$MAC_STR"'/' ethercat
sed -i '56s/.*/DEVICE_MODULES="generic"/' ethercat

# Copy some files #################################################################
sudo ln -s /epics/drivers/ethercat/etherlabmaster-code/sysroot/bin/ethercat /bin/ethercat
sudo mkdir /etc/sysconfig/
sudo cp /epics/drivers/ethercat/etherlabmaster-code/sysroot/etc/sysconfig/ethercat /etc/sysconfig/
sudo cp /epics/drivers/ethercat/etherlabmaster-code/sysroot/lib/libethercat.* /usr/lib/
sudo depmod

# Final check #####################################################################
sudo /etc/init.d/ethercat start
echo "Press [ENTER] if ethercat app started correctly"
read foo

# Install java for CSS (from repository) ##########################################
sudo apt-get install software-properties-common
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update
sudo apt-get install oracle-java8-installer
java -version
echo "Press [ENTER] if Oracle Java installed correctly"
read foo


# Uninstall RT Kernel and reboot @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#sudo apt-get remove linux-source-3.4.69-rt85
#sudo apt-get remove linux-headers-3.4.69-rt85
#sudo apt-get remove linux-image-3.4.69-rt85
#cd /lib/modules/
#sudo rm -r 3.4.69-rt85/
#sudo grub-mkconfig -o /boot/grub/grub.cfg
# sudo reboot
