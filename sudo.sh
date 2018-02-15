#!/usr/bin/env bash

# This script is called automatically by `pi-setup.sh` to run a batch of Pi setup commands that require sudo permissions

# Add globally accessible DNS servers to resolv.conf
sed -i '' 's/nameserver/#nameserver/g' /etc/resolv.conf
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
echo "nameserver 8.8.4.4" >> /etc/resolv.conf
service networking restart

# Update the time (from google, to ensure https works)
date -s "$(wget -qSO- --max-redirect=0 google.com 2>&1 | grep Date: | cut -d' ' -f5-8)Z"

export serial=`cat /proc/cpuinfo | grep Serial | cut -d ' ' -f 2`

# Fix the keyboard layout
curl https://raw.githubusercontent.com/danclegg/hc_deploy/feature/setup-sh/files/keyboard > /etc/default/keyboard

# Set hostname
echo -e "HC_$serial" > /etc/hostname
echo -e "127.0.1.1\tHC_$serial" >> /etc/hosts

# Install Salt-Minion on Pi and configure minion to talk to the salt-master
wget -O - https://repo.saltstack.com/apt/debian/8/armhf/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
curl https://raw.githubusercontent.com/danclegg/hc_deploy/feature/setup-sh/files/saltstack.list > /etc/apt/sources.list.d/saltstack.list

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
sed -i 's/\$PI_HOSTNAME/HC_'$serial'/' /etc/salt/minion
echo "HC_$serial" >> /etc/salt/minion_id
systemctl restart salt-minion

# Patch the Dirty COW kernel vulnerability
# apt -y install raspberrypi-kernel


# Configure automatic login for the `pi` user
mkdir -pv /etc/systemd/system/getty@tty1.service.d/
curl https://raw.githubusercontent.com/byuoitav/raspi-deployment-microservice/master/files/autologin.conf > /etc/systemd/system/getty@tty1.service.d/autologin.conf
systemctl enable getty@tty1.service

# Enable SSH connections
touch /boot/ssh
curl https://raw.githubusercontent.com/danclegg/hc_deploy/feature/setup-sh/files/sshbanner > /etc/sshbanner
sed -ie 's/#Banner none/Banner \/etc\/sshbanner/g' /etc/ssh/sshd_config

# Restart SSH to load banner change
service ssh restart

# Set the timezone
cp /usr/share/zoneinfo/America/Denver /etc/localtime

# Add the `pi` user to the sudoers group
usermod -aG sudo pi

# set ntp
curl https://raw.githubusercontent.com/danclegg/hc_deploy/feature/setup-sh/files/ntp.conf > /etc/ntp.conf
apt -y install ntpdate
systemctl stop ntp
ntpdate-debian
systemctl start ntp
ntpq -p

# Install Git
apt -y install git

# Configure git email and user name for pull requests
git config --global user.email "someuser@hcsystems.org"
git config --global user.name "Some User"
