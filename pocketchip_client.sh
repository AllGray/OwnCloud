#!/bin/sh

# Grab Hostname
read -s -p "What is your HOSTNAME: " hostname

wget -O /home/chip/Pictures/owncloud.png https://daniel.molkentin.net/wp-content/uploads/sites/2/2013/04/owncloud-icon-2561.png

# Create PocketHOME icon
cat >/home/chip/pocketcloud <<EOL
        {
          "name": "Owncloud",
          "icon": "/home/chip/Pictures/owncloud.png",
          "shell": "surf $hostname.local/owncloud"
        },
EOL

sed -n 1,5p pocketcloud
sed -i 6rpocketcloud ~/.pocket-home/config.json
