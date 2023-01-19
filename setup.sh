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

echo -e "\033[0;35m *** Enter CDN: \033[0m"
read varname
export CDN_NAME=$varname

echo -e "\033[0;35m *** Enter VPN NAME: \033[0m"
read varname
export VPN_NAME=$varname

echo $DOMAIN_NAME
# Setup Xray 
bash -c "$(curl -L https://github.com/thehxdev/xray-install/raw/main/xray.sh)"
# Install Requrements
apt install ufw curl git nginx nginx-common -y
# Setup nginx  
rm /var/www/html/*
rm /etc/nginx/sites-enabled/default
cp ./default /etc/nginx/sites-enabled/
chmod 777 /etc/nginx/sites-enabled/default

nano /etc/nginx/sites-enabled/default

systemctl enable nginx 
nginx -t
systemctl start nginx 
nginx -s reload


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
cp /root/Freedom-internet/config.json /usr/local/etc/xray/
systemctl restart xray
systemctl status xray
echo "************   DONE   *************"
echo -e "  \033[0;34m .............. Rebooting ..............\n \033[0;35m     Please SSH with port 36963 \033[0m"
reboot
