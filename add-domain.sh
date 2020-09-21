#!/bin/sh
echo "please put domain name:"
read domain
mkdir -p "/var/www/$domain/public_html"
chmod 755 "/var/www/$domain/public_html"
echo "please put proxy ip:port
ex:127.0.0.1:3000"
read proxy
echo "server {
	listen 80;
	server_name $domain www.$domain;
	root /var/www/$domain/public_html;
    index index.html index.htm;
   location / {
		proxy_pass http://$proxy;
                proxy_http_version 1.1;
                proxy_set_header Upgrade \$http_upgrade;
                proxy_set_header Connection 'upgrade';
                proxy_set_header Host \$host;
                proxy_set_header X-Real-IP \$remote_addr;
                proxy_set_header X-Fowarded-For \$proxy_add_x_forwarded_for;
                proxy_set_header X-Fowarded-Proto \$scheme;
                proxy_cache_bypass \$http_upgrade;
   }
   error_page 500 502 503 504 /50x.html;
   location = /50x.html {
      root html;
   }
}
server {
	listen 80;
	server_name statics.$domain;
	root /var/www/$domain/public_html;
	location / {
		alias /var/www/$domain/public_html/public/;
		autoindex off;
	}
}">"/etc/nginx/sites-available/$domain.conf"
ln -s "/etc/nginx/sites-available/$domain.conf" "/etc/nginx/sites-enabled/$domain.conf"
echo "now you can restart your nginx server"
