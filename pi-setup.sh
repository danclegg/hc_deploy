#!/bin/bash

# This script is used to install and set up dependencies on a newly wiped/installed Raspberry Pi
# For clean execution, run this script inside of the /tmp directory with `./pi-setup.sh`
# The script assumes the username of the autologin user is "pi"

# Download setup scripts
curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/sudo.sh > /tmp/sudo.sh
curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/grass.sh > /tmp/grass.sh

# Run Greengrass setup script
chmod +x /tmp/sudo.sh
sudo sh -c "bash /tmp/sudo.sh"

curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/files/bash_profile > /home/pi/.bash_profile

# Run Greengrass setup script
chmod +x /tmp/grass.sh
sudo sh -c "bash /tmp/grass.sh"

#sudo sh -c "reboot"
