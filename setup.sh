cd
apt update -y
apt upgrade -y
apt install ufw curl git -y
ufw allow 22
ufw allow 53 
ufw allow 443
ufw allow 8443
ufw allow 8080
ufw allow 80
ufw enable 
git clone https://github.com/Pokiledaa/Xray-ClientManager
cd Xray-ClientManager
./setup.sh
cd
wget -N --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && bash bbr.sh
rm bbr* install*
bash -c "$(curl -L https://github.com/thehxdev/xray-install/raw/main/xray.sh)"
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