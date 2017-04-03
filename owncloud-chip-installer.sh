#!/bin/bash

# Check if user is root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Grab a password for MySQL Root
read -s -p "Enter the password that will be used for MySQL Root: " mysqlrootpassword
debconf-set-selections <<< "mysql-server mysql-server/root_password password $mysqlrootpassword"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $mysqlrootpassword"

# Grab a password for owncloud Database User Account
read -s -p "Enter the password that will be used for the owncloud database: " ownclouddbuserpassword

# Setup OwnCloud Files
wget -nv https://download.owncloud.org/download/repositories/stable/Debian_8.0/Release.key -O Release.key
apt-key add - < Release.key

# Add the OwnCloud repository
sh -c "echo 'deb http://download.owncloud.org/download/repositories/stable/Debian_8.0/ /' > /etc/apt/sources.list.d/owncloud.list"
apt-get update

# Install Features
apt-get install ntfs-3g owncloud

echo $?

# If Apt-Get fails to run completely the rest of this isn't going to work...
if [ $? -ne 0 ]
then
    echo "Make sure to run: sudo apt-get update && sudo apt-get upgrade"
    exit
fi

# Make Changes to the PHP 
sed -ie 's/^memory_limit =.*$/memory_limit = 256M/g' /etc/php5/apache2/php.ini
sed -ie 's/^upload_max_filesize =.*$/upload_max_filesize = 2000M/g' /etc/php5/apache2/php.ini
sed -ie 's/^post_max_size =.*$/post_max_size = 2000M/g' /etc/php5/apache2/php.ini
sed -ie 's/^max_execution_time =.*$/max_execution_time = 300/g' /etc/php5/apache2/php.ini

# Create directory for mounting external drives to
mkdir /media/ownclouddrive

# Create and add the www-data user to the www-data group
usermod -a -G www-data www-data

# Make the user www-data owner of the mounted drive and make its permissions read, write and execute
chown -R www-data:www-data /media/ownclouddrive
chmod -R 775 /media/ownclouddrive

# Restart Apache
systemctl restart apache2

# Create OwnCloud DB and grant owncloud User permissions to it

# SQL Code
SQLCODE="
create database owncloud;
create user 'owncloud'@'localhost' identified by \"$ownclouddbuserpassword\";
GRANT SELECT,INSERT,UPDATE,DELETE ON owncloud.* TO 'owncloud'@'localhost';
flush privileges;"

# Execute SQL Code
echo $SQLCODE | mysql -u root -p$mysqlrootpassword

