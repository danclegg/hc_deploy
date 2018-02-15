#!/usr/bin/env bash

# This script is called automatically by `pi-setup.sh` to run a batch of Pi setup commands that require sudo permissions
# Source: https://docs.aws.amazon.com/greengrass/latest/developerguide/module1.html

# Add greengrass user & group
sudo adduser --system ggc_user
sudo addgroup --system ggc_group

# Install sqlite3
sudo apt-get update
sudo apt-get install -y sqlite3
