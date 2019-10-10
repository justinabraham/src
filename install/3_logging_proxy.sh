#!/bin/bash

# Adds proxy settings to your .bashrc file in your $HOME directory (appends to existing file)
## HERE 1/2 ##
# nano ~/.bashrc
## ##
echo "http_proxy=http://proxy.tlabs.ac.za:3128" | tee -a ~/.bashrc
echo "export http_proxy" | tee -a ~/.bashrc
echo "https_proxy=http://proxy.tlabs.ac.za:3128" | tee -a ~/.bashrc
echo "export https_proxy" | tee -a ~/.bashrc
echo "ftp_proxy=http://proxy.tlabs.ac.za:3128" | tee -a ~/.bashrc
echo "export ftp_proxy" | tee -a ~/.bashrc
echo "alias ll='ls -al --color=yes'" | tee -a ~/.bashrc
source ~/.bashrc

# Allow sudoers access to proxies by editing file (appends to existing file)
## HERE 2/2 ##
# nano /etc/sudoers
## ##
sed -i '12i\Defaults env_keep = "http_proxy https_proxy ftp_proxy"\' /etc/sudoers

# Prevent system logs from filling up harddrive
sed -i '3s/.*/	rotate 2/' /etc/logrotate.d/rsyslog
sed -i '27s/.*/	rotate 2/' /etc/logrotate.d/rsyslog
sed -i '4i\        maxsize 1000\' /etc/logrotate.d/rsyslog
sed -i '29i\        maxsize 1000\' /etc/logrotate.d/rsyslog
echo ":programname,isequal,\"gnome-session\" ~" | tee --append /etc/rsyslog.d/gnome-session-log.conf
cd /etc/init.d/
service rsyslog stop
update-rc.d -f rsyslog remove
mv rsyslog ~/
cd /etc/systemd/system/
mv syslog.service ~/
