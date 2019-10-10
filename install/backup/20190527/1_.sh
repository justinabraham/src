# Enter tlabs proxies into apt.conf file (overwrites existing file!)
# Done in 0_2_initial_settings_apt-sources.sh
#echo "Acquire::http::proxy \"http://proxy.tlabs.ac.za:3128/\";" | sudo tee /etc/apt/apt.conf
#echo "Acquire::ftp::proxy \"http://proxy.tlabs.ac.za:3128/\";" | sudo tee -a /etc/apt/apt.conf
#echo "Acquire::https::proxy \"http://proxy.tlabs.ac.za:3128/\";" | sudo tee -a /etc/apt/apt.conf

# Adds proxy settings to your .bashrc file in your $HOME directory (appends to existing file)
## HERE 1/2 ##
# sudo nano ~/.bashrc
## ##
echo "http_proxy=http://proxy.tlabs.ac.za:3128" | sudo tee -a ~/.bashrc
echo "export http_proxy" | sudo tee -a ~/.bashrc
echo "https_proxy=http://proxy.tlabs.ac.za:3128" | sudo tee -a ~/.bashrc
echo "export https_proxy" | sudo tee -a ~/.bashrc
echo "ftp_proxy=http://proxy.tlabs.ac.za:3128" | sudo tee -a ~/.bashrc
echo "export ftp_proxy" | sudo tee -a ~/.bashrc
echo "alias ll='ls -al --color=yes'" | sudo tee -a ~/.bashrc
source ~/.bashrc

# Allow sudoers access to proxies by editing file (appends to existing file)
## HERE 2/2 ##
# sudo nano /etc/sudoers
## ##
sudo sed -i '12i\Defaults env_keep = "http_proxy https_proxy ftp_proxy"\' /etc/sudoers

# Add local repositories (overwrites existing file!)
# Done in 0_2_initial_settings_apt-sources.sh
#echo "deb http://ftp.leg.uct.ac.za/debian stable main" | sudo tee /etc/apt/sources.list
#echo "deb http://ftp.leg.uct.ac.za/debian-security stable/updates main" | sudo tee -a /etc/apt/sources.list
#sudo apt-get update

# Configure eth0 as default network card for network access (appends to existing file)
# Done in 0_1_initial_settings_NIC.sh
#echo "auto eth0" | sudo tee -a /etc/network/interfaces
#echo "allow-hotplug eth0" | sudo tee -a /etc/network/interfaces
#echo "iface eth0 inet dhcp" | sudo tee -a /etc/network/interfaces
# SERVER ADDITIONS #
# Configure eth1 as hotplug and up (appends to existing file)
#echo "auto eth1" | sudo tee -a /etc/network/interfaces
#echo "allow-hotplug eth1" | sudo tee -a /etc/network/interfaces
#echo "iface eth1 inet manual" | sudo tee -a /etc/network/interfaces
#echo "	pre-up ifconfig $IFACE up" | sudo tee -a /etc/network/interfaces
#echo "	post-down ifconfig $IFACE down" | sudo tee -a /etc/network/interfaces
# SERVER ADDITIONS #

# Prevent system logs from filling up harddrive
sudo sed -i '3s/.*/	rotate 2/' /etc/logrotate.d/rsyslog
sudo sed -i '27s/.*/	rotate 2/' /etc/logrotate.d/rsyslog
sudo sed -i '4i\        maxsize 1000\' /etc/logrotate.d/rsyslog
sudo sed -i '29i\        maxsize 1000\' /etc/logrotate.d/rsyslog
echo ":programname,isequal,\"gnome-session\" ~" | sudo tee --append /etc/rsyslog.d/gnome-session-log.conf
cd /etc/init.d/
sudo service rsyslog stop
sudo update-rc.d -f rsyslog remove
sudo mv rsyslog ~/
cd /etc/systemd/system/
sudo mv syslog.service ~/
