#!/bin/bash

# Starting Alert
echo -e "  \033[0;34m ###### \033[0;32m Starting Freedom Script \033[0;34m ###### \033[0m"
# Update Proccess
apt update -y
apt upgrade -y
# Get Domain 
echo -e "\033[0;35m *** Enter Domain: \033[0m"
read varname
export DOMAIN_NAME=$varname
echo $DOMAIN_NAME
# Setup Xray 
bash -c "$(curl -L https://github.com/thehxdev/xray-install/raw/main/xray.sh)"
# Install Requrements
apt install ufw curl git nginx nginx-common -y
# Setup nginx  
envsubst < ./default
rm /etc/nginx/sites-enabled/default
cp ./default /etc/nginx/sites-enabled/default
chmod 777 /etc/nginx/sites-enabled/default

systemctl enable nginx 
nginx -t
systemctl start nginx 
nginx -s reload
# Setup Fake website
rm /var/www/html/*
cp ./html/* /var/www/html
# Change SSH port
rm /etc/ssh/sshd_config
cp ./sshd_config /etc/ssh/
# Setup Firewall
ufw allow 36963
ufw allow 53 
ufw allow 443
ufw allow 8442
ufw allow 8443
ufw allow 8444
ufw allow 8445
ufw allow 8080
ufw allow 80
ufw enable 
# Setup Xray-ClientManager (Thank you alot Parsa )
cd
git clone https://github.com/Pokiledaa/Xray-ClientManager
cd Xray-ClientManager
./setup.sh
# Setup BBR
cd
wget -N --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
rm bbr* install*
# Xray Config
mv /usr/local/etc/xray/config.json /usr/local/etc/xray/config.json.old
nano /usr/local/etc/xray/config.json
systemctl restart xray
systemctl status xray
echo "************   DONE   *************"





# input domain 
apt install nginx nginx-full python3-certbot-nginx -y
rm /etc/nginx/sites-enabled/default
certbot --nginx -d a4.snapfood.cloud
cp default /etc/nginx/sites-enabled/




server {
    listen 80 default_server;
    listen [::]:80 default_server;
    root /var/www/html;
    server_name a4.snapfood.cloud ;
}