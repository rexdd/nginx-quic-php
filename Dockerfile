FROM centos:8.2.2004
LABEL MAINTAINER "admin@51bbo.com"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" >> /etc/timezone \
    && mkdir -p /app/data/site /etc/nginx/ssl \
    && dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm \
    && dnf install -y epel-release yum-plugin-copr \
    && dnf copr enable -y ryoh/nginx-quic \
    && dnf install -y nginx-quic \
    && dnf install -y php80-php php80-php-fpm php80-php-gd \
    php80-php-mysqlnd php80-php-opcache php80-php-mbstring \
    && dnf clean all \
    && rm -rf /var/cache/yum/* \
    && rm -f /etc/nginx/vhost.d/http/00-default.conf \
    && sed -i '/listen =/s/= .*/= 127.0.0.1:9000/' /etc/opt/remi/php80/php-fpm.d/www.conf

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