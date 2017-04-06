#!/bin/sh


# Clear the screen
reset

# Start info
echo "+-----------------------------------------------------------+"
echo "|                         IMPORTANT                         |"
echo "|  If you have Netatalk installed use the servers HOSTNAME  |"
echo "|            If you dont have Netatalk installed            |"
echo "|            use your owncloud servers IP Addess            |"
echo "+-----------------------------------------------------------+"

# Grab Hostname
read -p "What is your servers HOSTNAME/local ip address : " hostname

wget -O /home/chip/Pictures/owncloud.png https://raw.githubusercontent.com/AllGray/OwnCloud/master/owncloud.png

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

# Clear screen
reset

# Finishing up
echo "+------------------------------------------------------+"
echo "|                   Congratulation !                   |"
echo "|                 Your install is done                 |"
echo "| Please restart you pocketCHIP for the icon to appear |"
echo "|                                                      |"
echo "|                                                      |"
echo "|                                                      |"
echo "|                                                      |"
echo "|                                                      |"
echo "|                                                      |"
echo "|    This installer was brought to you by AllGray! !   |"
echo "+------------------------------------------------------+"
