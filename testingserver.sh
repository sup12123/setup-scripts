#!/bin/bash

echo "Debian server setup script so i dont have to do this a million more times"
sleep 3
echo "run this script as root. press Ctrl+C if you are not root"
sleep 5
echo "nextcloud install"
apt update
apt install sudo -y
apt install apache2 -y
systemctl enable apache2
sudo a2enmod ssl rewrite headers
systemctl restart apache2
sudo apachectl -M | egrep "ssl|rewrite|headers"
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main"\ | sudo tee /etc/apt/sources.list.d/sury-php.list
apt install curl -y
curl -o /etc/apt/trusted.gpg.d/sury-php8.gpg https://packages.sury.org/php/apt.gpg
apt update
apt install -y php php-curl php-cli php-mysql php-gd php-common php-xml php-json php-intl php-pear php-imagick php-dev php-common php-mbstring php-zip php-soap php-bz2 php-bcmath php-gmp php-apcu
apt install -y libmagickcore-dev
cd /etc/php/8.1/apache2/
