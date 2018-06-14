#!/bin/bash

echo 'nameserver 202.96.209.5' >> /etc/resolv.conf
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
\cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

yum -y install lrzsz gcc make apr-devel apr-util openssl-devel vim \
open-vm-tools net-tools unzip wget chrony telnet iostat nethogs

yum install nginx -y 

#yum install libxml2 libxml2-devel openssl openssl-devel bzip2 bzip2-devel \
#libcurl libcurl-devel libjpeg libjpeg-devel libpng libpng-devel \
#freetype freetype-devel gmp gmp-devel libmcrypt libmcrypt-devel \
#readline readline-devel libxslt libxslt-devel pcre pcre-devel

rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm  
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm  

yum install php70w php70w-bcmath php70w-cli php70w-common php70w-dba \
php70w-devel php70w-embedded php70w-enchant php70w-fpm php70w-gd \
php70w-imap php70w-interbase php70w-intl php70w-ldap php70w-mbstring \
php70w-mcrypt php70w-mysql php70w-odbc php70w-opcache \
php70w-pdo php70w-pdo_dblib php70w-pear php70w-pecl-apcu \
php70w-pecl-imagick php70w-pecl-xdebug php70w-pgsql php70w-phpdbg \
php70w-process php70w-pspell php70w-recode php70w-snmp php70w-soap \
php70w-tidy php70w-xml php70w-xmlrpc

cat >> /etc/yum.repos.d/Mariadb.repo << EOF
# MariaDB 10.1 CentOS repository list - created 2016-12-01 03:36 UTC
# http://downloads.mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF
yum -y install MariaDB-server MariaDB-client
systemctl start mysql
systemctl enable mysql
/usr/bin/mysqladmin -u root password 'Imio.Baic.i0'

sed -i 's/;date.timezone = /date.timezone = Asia/Shanghai/g' /etc/php.ini
sed -i 's/apache/nginx/g' /etc/php-fpm.d/www.conf
sed -i 's/127.0.0.1:9000/\/dev\/shm\/php-fpm.sock/g' /etc/php-fpm.d/www.conf 

chown -R nginx:nginx /var/log/php-fpm
rm -rf /etc/nginx/nginx.conf

cat >> /etc/nginx/nginx.conf << EOF
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
#include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

#    server {
#        listen       80 default_server;
#        listen       [::]:80 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /run/nginx.pid;

# Load dynamic modules. See /usr/share/nginx/README.dynamic.
#include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

#    server {
#        listen       80 default_server;
#        listen       [::]:80 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#        listen       80 default_server;
#        listen       [::]:80 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }
#
# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl http2 default_server;
#        listen       [::]:443 ssl http2 default_server;
#        server_name  _;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_ciphers HIGH:!aNULL:!MD5;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }
}
EOF

cat >> /etc/nginx/conf.d/www.conf << EOF
server
{
    listen 8088; 
    server_name default.com www.default.com; 
    index index.html index.htm index.php; 
    charset utf-8; 

    root  /var/www; 

    location ~ .*\.php$ {
    	root     /var/www;
        fastcgi_pass  unix:/dev/shm/php-fpm.sock; 
        fastcgi_index index.php;
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include        fastcgi_params;
    }

    
    location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|flv|mp3|wma)$ {
        expires      30d;
    }

    location ~ .*\.(js|css)$ {
        expires      12h;
    }
    
    access_log /var/log/nginx/access.log main;
    error_log /var/log/nginx/error.log crit;
}
EOF

systemctl start php-fpm
systemctl start nginx
chown -R nginx:nginx /dev/shm/php-fpm.sock

cat >> /var/www/info.php << EOF
<?php
phpinfo();
?>
EOF

curl localhost/info.php


