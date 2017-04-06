#!/bin/sh


# Start info
echo "+---------------------------------------------------------------------+"
echo "|                            IMPORTANT                                |"
echo "|      If you have Netatalk installed use the servers HOSTNAME        |"
echo "|  If you don't have Netatalk installed, use your servers IP Addess   |"
echo "|                                                                     |"
echo "+---------------------------------------------------------------------+"

# Grab Hostname
read -s -p "What is your servers HOSTNAME/local ip address : " hostname

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

# Clean up
rm -r pocketcloud pocketchip_owncloud_client.sh

# Finishing up
echo "+---------------------------------------------------------------------+"
echo "|                         Congratulation!                             |"
echo "|                      Your install is done.                          |"
echo "|        Please restart you pocketCHIP for the icon to appear         |"
echo "|                                                                     |"
echo "|                                                                     |"
echo "|                                                                     |"
echo "|                                                                     |"
echo "|                                                                     |"
echo "|                                                                     |"
echo "|            This installer was brought to you buy AllGray            |"
echo "+---------------------------------------------------------------------+"
