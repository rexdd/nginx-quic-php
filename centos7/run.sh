#!/bin/bash

export env
echo 'export PATH=$PATH:/opt/remi/php80/root/usr/bin' >>/etc/profile
source /etc/profile

/usr/sbin/nginx
/opt/remi/php80/root/usr/sbin/php-fpm --daemonize

tail -f /var/log/nginx/*.log
