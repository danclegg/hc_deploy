#!/usr/bin/env bash

mkdir -p /home/pi/downloads && cd /home/pi/downloads

sudo sh -c "sed -i '' 's/nameserver/#nameserver/g' /etc/resolv.conf"
sudo sh -c "echo \"nameserver 8.8.8.8\" >> /etc/resolv.conf"
sudo sh -c "echo \"nameserver 8.8.4.4\" >> /etc/resolv.conf"
sudo sh -c "service networking restart"

sudo sh -c "sudo apt-get install -y git"

# Get greengrass checker
git clone https://github.com/aws-samples/aws-greengrass-samples.git

cd aws-greengrass-samples
cd greengrass-dependency-checker-GGCvx.x.x
sudo modprobe configs

#sudo ./check_ggc_dependencies | more
