#!/bin/bash

# Root permissions check
if [ "$EUID" -ne 0 ]; then
  echo -e "\033[1;31m[-] Kripya is script ko root user se chalayein (sudo bash).\033[0m"
  exit 1
fi

clear

while true; do
    # Aapka ASCII Art Header
    echo -e "\033[1;36m"
    echo " __  __    ____   __   __  _____    _                __    __  ______"
    echo "|  \/  | |___ \   \ V /  |  __ \  | |         /\     \ \  / / |___  /"
    echo "| |\/| |   __) |   \ V /   | |__) | | |        /  \     \ \/ /      / / "
    echo "| |  | |  |__ <     > <    |  ___/  | |       / /\ \     \  /      / /  "
    echo "| |  | |  ___) |   / . \   | |      | |____  / ____ \    | |      / /__ "
    echo "|_|  |_| |____/   /_/ \_\  |_|      |______|/_/    \_\   |_|     /_____|"
    echo -e "------------------------------------------------------------"
    echo -e " 1. Install pterodactyl"
    echo -e " 2. Install wings" "_________________________________________________"
    echo -e "\033[0m"

    read -p "Apna option chunein [1-4]: " choice

    case $choice in
  
             1)
            echo -e "\n\033[1;32m[+] Pterodactyl installation shuru ho rahi hai...\033[0m"
sudo apt update && sudo apt upgrade -y
sudo apt install -y software-properties-common ca-certificates curl git unzip tar nginx mariadb-server redis-server
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install -y php8.3 php8.3-cli php8.3-gd php8.3-mysql php8.3-mbstring php8.3-bcmath php8.3-xml php8.3-curl php8.3-zip php8.3-fpm php8.3-intl
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
sudo mkdir -p /var/www/pterodactyl
cd /var/www/pterodactyl
sudo curl -Lo panel.tar.gz 
https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz
sudo tar -xzvf panel.tar.gz
sudo composer install --no-dev --optimize-autoloader
sudo cp .env.example .env
sudo php artisan key:generate --force
sudo chown -R www-data:www-data /var/www/pterodactyl


            echo -e "\n\033[1;32m[+]  Enjoy Your New Pterodactyl Panel!\033[0m"
            echo ""
            read -p "Main menu par jaane ke liye [Enter] dabayein..."
            ;;
            2)
            echo -e "\n\033[1;32m[+] Wings installation shuru ho rahi hai...\033[0m"
curl -fsSL https://get.docker.com | sudo sh
sudo systemctl enable --now docker
sudo mkdir -p /etc/pterodactyl
sudo curl -L https://github.com/pterodactyl/wings/releases/latest/download/wings_linux_amd64 -o /usr/local/bin/wings
sudo chmod u+x /usr/local/bin/wings
wings --version
sudo mysql_secure_installation
sudo mariadb
CREATE DATABASE panel;
CREATE USER 'pterodactyl'@'127.0.0.1' IDENTIFIED BY 'CHANGE_THIS_PASSWORD';
GRANT ALL PRIVILEGES ON panel.* TO 'pterodactyl'@'127.0.0.1';
FLUSH PRIVILEGES;
EXIT;
cd /var/www/pterodactyl
php artisan p:environment:database
     [+] It will ask for the database details. Use:
Host: vps ip
Port: your port
Database: panel
Username: pterodactyl
Password: the password you set in command 22
 echo -e "\n\033[1;32m[+]  Wings Installation has been done \033[0m"
            echo ""
            read -p "Main menu par jaane ke liye [Enter] dabayein..."
    esac
    clear
done
