#!/bin/bash
# By default we install the latest composer version.
# https://getcomposer.org/

# Set Variables
ansible_helper_dir=$1
composer_bin=$2
flag_file_composer=$3
tmp_dir="/tmp/composer"

# Create temp dir
mkdir -p $tmp_dir && cd $tmp_dir

# Download composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

# Move composer in $PATH
mv composer.phar $composer_bin
# Assure executable
chmod +x $composer_bin

# Leave a trace. 
# This is done so we can set condition in ansible:
# to execute this script only if the below file does not exist.

mkdir -p $ansible_helper_dir
echo "composer version v2.5.5 installed" > "${ansible_helper_dir}/${flag_file_composer}"

# Clean up tmp dir
rm -rf $tmp_dir

# Print success message
echo "Composer installation completed!"

exit 0