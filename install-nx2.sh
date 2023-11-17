#!/bin/sh
echo "======================================="
echo "=       INSTALL NGINX and NODEJS      ="
echo "======================================="
echo ""
echo ""
echo ""
echo "installing nginx ..."
echo ""
sudo service httpd stop
sudo systemctl disable httpd
sudo yum -y install epel-release
sudo yum -y curl wget
sudo yum -y install nginx
sudo service nginx start
echo "setup nginx config ..."
echo "
user nginx;
worker_processes auto;
worker_rlimit_nofile 100000;
error_log /var/log/nginx/error.log crit;
pid /run/nginx.pid;
include /usr/share/nginx/modules/*.conf;
events {
    worker_connections 4000;
    use epoll;
    multi_accept on;
}

http {
    log_format  main  '\$remote_addr - \$remote_user [\$time_local] \"\$request\" '
                      '\$status \$body_bytes_sent \"\$http_referer\" '
                      '\"\$http_user_agent\" \"\$http_x_forwarded_for\"';
    access_log  /var/log/nginx/access.log  main;
    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   30;
    types_hash_max_size 2048;
	keepalive_requests 100000;
	
	open_file_cache max=200000 inactive=20s;
    open_file_cache_valid 30s;
    open_file_cache_min_uses 2;
    open_file_cache_errors on;
	
	access_log off;
	
	
	gzip on;
    # gzip_static on;
    gzip_min_length 10240;
    gzip_comp_level 1;
    gzip_vary on;
    gzip_disable msie6;
    gzip_proxied expired no-cache no-store private auth;
    gzip_types
        text/css
        text/javascript
        text/xml
        text/plain
        text/x-component
        application/javascript
        application/x-javascript
        application/json
        application/xml
        application/rss+xml
        application/atom+xml
        font/truetype
        font/opentype
        application/vnd.ms-fontobject
        image/svg+xml;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    include /etc/nginx/conf.d/*.conf;

    server {
        listen       80 default_server;
        #listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        include /etc/nginx/default.d/*.conf;

        location / {
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
    }
include /etc/nginx/sites-enabled/*.conf;
server_names_hash_bucket_size 64;
}">"/etc/nginx/nginx.conf"
mkdir /etc/nginx/sites-available
mkdir /etc/nginx/sites-enabled
sudo systemctl enable nginx
sudo service nginx restart
echo "installing nodejs ..."
sudo yum install https://rpm.nodesource.com/pub_20.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm -y
sudo yum install nodejs -y --setopt=nodesource-nodejs.module_hotfixes=1
sudo yum -y install gcc-c++ make
sudo yum -y install pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 alsa-lib.x86_64 atk.x86_64 gtk3.x86_64 ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc
sudo npm install pm2 -g
sudo yum -y install sendmail sendmail-cf
sudo make -C /etc/mail
sudo service sendmail restart
echo "done everything installed."
