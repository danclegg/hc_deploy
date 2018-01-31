#!/bin/bash
# This script should live in /usr/bin/ on the rasbian img. It will run once on the first boot of the pi, and then disable the service.

sleep 15

printf "\n\nDownloading assets\n\n"

sudo chvt 2

echo "First boot."

while true; do
  curl https://raw.githubusercontent.com/danclegg/hc_deploy/feature/setup-sh/pi-setup.sh > /tmp/pi-setup.sh
  if [ $? -eq 0 ]; then
      break
  fi
  sleep 5
done

sudo chmod 755 /tmp/pi-setup.sh

echo "Running PI setup script . . ."
/tmp/pi-setup.sh

echo "Removing symlink to startup script."
sudo rm /usr/lib/systemd/system/default.target.wants/first-boot.service

clear
printf "\n\n\n\n\n\n"
printf "Setup complete!"
printf "\n\tPlease wait for me to reboot.\n"
sleep 20
printf "\n\nBye"
sleep 5

sudo sh -c "reboot"
