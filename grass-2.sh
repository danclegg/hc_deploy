#!/usr/bin/env bash

# This script is called after grass.sh
# Source: https://docs.aws.amazon.com/greengrass/latest/developerguide/module1.html

# Comment out execution of this script on login
sed -i -e "s/.green2/.green3/g" /home/pi/.bash_profile


if [ -f /etc/sysctl.d/98-rpi.conf ]; then
    sudo sh -c "echo \"fs.protected_hardlinks = 1\" >> /etc/sysctl.d/98-rpi.conf"
    sudo sh -c "echo \"fs.protected_symlinks = 1\" >> /etc/sysctl.d/98-rpi.conf"
else
    sudo sh -c "touch /etc/sysctl.d/98-rpi.conf"
    sudo sh -c "echo \"kernel.printk = 3 4 1 3\" >> /etc/sysctl.d/98-rpi.conf"
    sudo sh -c "echo \"vm.min_free_kbytes = 16384\" >> /etc/sysctl.d/98-rpi.conf"
    sudo sh -c "echo \"fs.protected_hardlinks = 1\" >> /etc/sysctl.d/98-rpi.conf"
    sudo sh -c "echo \"fs.protected_symlinks = 1\" >> /etc/sysctl.d/98-rpi.conf"
fi


chmod +x /home/pi/grass-3.sh

sudo reboot
