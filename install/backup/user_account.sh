#!/bin/bash
# echo Hello World
# Install dependencies ############################################################
su
apt-get install sudo
echo "Would you like to change the username? (y/n)"
read user_choice
if [ "$user_choice" = "y" ];then
	echo "Please specify new username:"
	read new_username
	adduser $new_username
	adduser $new_username sudo
	sed -i '23i\$new_username ALL=(ALL:ALL) ALL\' /etc/sudoers
	exit
	echo "System is about to reboot. Please login into new user account on reboot. Press [ENTER] to reboot now."
	read foo
	sudo reboot
else
	adduser $(id -u -n) sudo
	sed -i '23i\$(id -u -n) ALL=(ALL:ALL) ALL\' /etc/sudoers
	exit
fi
