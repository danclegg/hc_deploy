#!/bin/bash

# This script is used to install and set up dependencies on a newly wiped/installed Raspberry Pi
# For clean execution, run this script inside of the /tmp directory with `./pi-setup.sh`
# The script assumes the username of the autologin user is "pi"

# Download setup scripts
curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/sudo.sh > /tmp/sudo.sh

# Run Greengrass setup script
chmod +x /tmp/sudo.sh
sudo sh -c "bash /tmp/sudo.sh"

curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/files/bash_profile > /home/pi/.bash_profile
curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/files/green2 > /home/pi/.green2
curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/files/green3 > /home/pi/.green3
curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/grass.sh > /home/pi/grass.sh
curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/grass-2.sh > /home/pi/grass-2.sh
curl https://raw.githubusercontent.com/danclegg/hc_deploy/master/grass-3.sh > /home/pi/grass-3.sh

# Run Greengrass setup script
chmod +x /home/pi/grass.sh
sudo sh -c "bash /home/pi/grass.sh"

#sudo sh -c "reboot"
