#!/usr/bin/env bash

# This script is called automatically by `pi-setup.sh` to run a batch of Pi setup commands that require sudo permissions

# Update the time (from google, to ensure https works)
date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"

export serial=`cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2`

# Fix the keyboard layout
curl https://raw.githubusercontent.com/byuoitav/raspi-deployment-microservice/master/files/keyboard > /etc/default/keyboard

# Set hostname
echo -e "hc_$serial" > /etc/hostname
echo -e "127.0.1.1\thc_$serial" >> /etc/hosts

# Install Salt-Minion on Pi and configure minion to talk to the salt-master
wget -O - https://repo.saltstack.com/apt/debian/8/armhf/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -

# Perform general updating
apt update
apt -y upgrade
apt -y dist-upgrade
apt -y autoremove
apt -y autoclean

sudo apt-get update
sudo apt-get -y install salt-minion

# Copy minion file and add minion
cp /srv/files/minion /etc/salt/minion

#PI_HOSTNAME=$(hostname)
sed -i 's/\$PI_HOSTNAME/'$desired_hostname'/' /etc/salt/minion
echo "$desired_hostname" >> /etc/salt/minion_id
systemctl restart salt-minion

# Patch the Dirty COW kernel vulnerability
# apt -y install raspberrypi-kernel
