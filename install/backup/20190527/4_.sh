#!/bin/bash
# echo Hello World
# Make base and support ##########################################################
cd /epics/base
sudo make clean
sudo make
cd /epics/support/
sudo make clean
sudo make
echo "Press [ENTER] if no errors in make of EPICS base and support"
read foo

# Install etherlabs driver #######################################################
cd /epics/drivers/ethercat/etherlabmaster-code
echo "Would you like to install on 3.4.69-rt85 kernel? (y/n)"
read rt_choice
if [ "$rt_choice" = "y" ];then
	sudo ./configure --enable-e1000e --disable-r8169 --disable-8139too --prefix=/epics/drivers/ethercat/etherlabmaster-code/sysroot --enable-sii-assign
else
	sudo ./configure --enable-generic --disable-r8169 --disable-8139too --prefix=/epics/drivers/ethercat/etherlabmaster-code/sysroot --enable-sii-assign
fi
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
if [ "$rt_choice" = "y" ];then
        sed -i '45s/.*/DEVICE_MODULES="e1000e"/' ethercat.conf
else
        sed -i '45s/.*/DEVICE_MODULES="generic"/' ethercat.conf
fi
# Second file ####################################################################
cd /epics/drivers/ethercat/etherlabmaster-code/sysroot/etc/sysconfig
sed -i '27s/.*/'"$MAC_STR"'/' ethercat
if [ "$rt_choice" = "y" ];then
        sed -i '56s/.*/DEVICE_MODULES="e1000e"/' ethercat
else
        sed -i '56s/.*/DEVICE_MODULES="generic"/' ethercat
fi

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
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-get update
sudo apt-get install oracle-java8-installer
java -version
echo "Press [ENTER] if Oracle Java installed correctly"
read foo
