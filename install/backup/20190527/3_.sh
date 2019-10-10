#!/bin/bash
# echo Hello World
# Install new e1000e driver ######################################################
# cd ~/ethercat
cd ..
cp e1000e-3.3.3.tar ../
cd ..
tar -xvf e1000e-3.3.3.tar
cd e1000e-3.3.3/src/
make clean
make
sudo make install
sudo cp e1000e.ko /lib/modules/3.4.69-rt85/kernel/drivers/net/ethernet/intel/e1000e/
# cd /lib/modules/3.4.69-rt85/kernel/drivers/net/ethernet/intel/e1000e/
#sudo rmmod e1000e.ko
sudo modprobe e1000e
cd ..
cd ..
sudo rm -r e1000e-3.3.3
rm e1000e-3.3.3.tar
echo "Press [ENTER] if no errors in installing e1000e driver"
read foo
# Update initramfs image #########################################################
sudo update-initramfs -v -u -k `uname -r`
echo "Press [ENTER] if no errors in updating initramfs"
read foo
echo "System is about to reboot. Choose 3.4.69-rt85 kernel under Advanced options in the Grub menu on reboot. Press [ENTER] to reboot now."
read foo
sudo reboot
