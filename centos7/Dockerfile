FROM centos:7.9.2009
LABEL MAINTAINER "admin@51bbo.com"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >> /etc/timezone \
    && mkdir -p /app/data/site /etc/nginx/ssl \
    && yum install -y epel-release \
    && rpm -ivh https://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && yum install -y centos-release-scl yum-plugin-copr \
    && yum copr enable -y ryoh/nginx-quic \
    && yum install -y nginx-quic \
    && yum install -y php74-php php74-php-fpm php74-php-gd \
    php74-php-mysqlnd php74-php-opcache php74-php-mbstring \
    && yum clean all \
    && rm -rf /var/cache/yum/* \
    && rm -f /etc/nginx/vhost.d/http/00-default.conf \
    && sed -i '/listen =/s/= .*/= 127.0.0.1:9000/' /etc/opt/remi/php74/php-fpm.d/www.conf

COPY site.conf /etc/nginx/vhost.d/http/
COPY site/* /app/data/site/
COPY ssl/* /etc/nginx/ssl/

COPY run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

EXPOSE 80/tcp
EXPOSE 443/tcp
EXPOSE 443/udp

ENTRYPOINT ["/usr/local/bin/run.sh"]
CMD ["/bin/bash"]