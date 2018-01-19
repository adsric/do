#!/bin/bash

# -----------------------------------------------------------------------

export DEBIAN_FRONTEND=noninteractive

# Add Vim 8.0 to Package list

sudo add-apt-repository ppa:jonathonf/vim

# Update Package List

apt update

# Update System Packages

apt -y upgrade

# Set Locale

echo "LC_ALL=en_GB.UTF-8" >> /etc/default/locale
locale-gen en_GB.UTF-8

# Set My Timezone

ln -sf /usr/share/zoneinfo/GMT /etc/localtime

# Install Composer

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Install Vim 8.0

apt install vim

# Setup PHP-CLI Options

sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.1/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = GMT/" /etc/php/7.1/cli/php.ini

# Setup PHP-FPM Options

sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.1/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 10M/" /etc/php/7.1/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 10M/" /etc/php/7.1/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = GMT/" /etc/php/7.1/fpm/php.ini

# Tweak Nginx

sed -i "s/# server_names_hash_bucket_size.*/server_names_hash_bucket_size 64;/" /etc/nginx/nginx.conf

# Restart Sevices

service nginx restart
service php7.1-fpm restart
