## Master PC and OS

This toolchain was tested on a desktop machine with Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz and 8 GB RAM.

The OS is a "headless" or network install of Debian GNU/Linux 10.1.0 (buster) running kernerl 4.19.0-6-rt-amd64 which has the PREEMPT RT patch applied.

cd into where the install scripts sit
	cd install/

su -c ./1_machine_settings.sh
	This script sets up the network interface cards, proxies and repositories
	You will be prompted to enter the names of the two NICs (typically eth0 and eth1 etc.)
	You must confirm that the connection with the local package repository is working correctly
	!!A system reboot is required at this point for the above settings to take effect!!

Once the PC has restarted continue with the scripts

su -c ./2_account_settings.sh
	This script sets up the user privileges for the current user

su -c ./3_logging_proxy.sh
	This script adds the proxies to the bashrc profile and disables logging

./4_rt_images.sh
	This script installs the rt patched kernel image, headers and support packages
	You must confirm that all three have installed correctly
	!!A system reboot is required at this point for the above settings to take effect!!

Once the PC has restarted continue with the scripts

./5_dependencies.sh
	This script installs all the dependencies required to build the various drivers
	You must confirm that all dependencies installed correctly
	
./6_extract_move_files.sh
	This script extract the zipped iThemba LABS EtherCAT archive into the correct location
	
./7_epics_base_support.sh
	This script builds the EPICS base and support
	You must confirm that both have installed correctly

./8_etherlab_ethercat.sh
	This scripts builds the etherlab scanner and ethercat app
	You will be prompted to enter the MAC of the NIC that connects to the EtherCAT slaves
	You must ensure that the etherlab driver started correctly
	You must ensure that the ethercat app built correctly
