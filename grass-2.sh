#!/usr/bin/env bash

# This script is called after grass.sh
# Source: https://docs.aws.amazon.com/greengrass/latest/developerguide/module1.html

# Comment out execution of this script on login
sed -i -e "s/source \/home\/pi\/.green2/#line was replaced/g" /home/pi/.bash_profile
