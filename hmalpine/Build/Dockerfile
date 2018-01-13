FROM alpine:3.6
ARG ARCH
RUN deluser xfs \
 && addgroup -g 33 apache \
 && adduser -u 33 -D -G apache -h /var/www apache -s /bin/nologin \
 && apk update &&  apk add bash apache2 \
php7-apache2 curl ca-certificates openssl openssh \
git php7 php7-phar php7-json php7-iconv php7-openssl \
openntpd \
php7-ftp \
php7-xdebug \
php7-opcache \
php7-mcrypt \
php7-mbstring \
php7-soap \
php7-gmp \
php7-pdo_odbc \
php7-dom \
php7-pdo \
php7-zip \
php7-zlib \
php7-mysqli \
php7-sqlite3 \
php7-pdo_pgsql \
php7-bcmath \
php7-gd \
php7-odbc \
php7-pdo_mysql \
php7-pdo_sqlite \
php7-gettext \
php7-xmlreader \
php7-imagick \
php7-intl \
php7-xmlwriter \
php7-tokenizer \
php7-xmlrpc \
php7-bz2 \
php7-pdo_dblib \
php7-curl \
php7-ctype \
php7-session \
php7-fileinfo \
php7-redis \
sudo \
tzdata
RUN apk add php7-simplexml && rm -rf /var/cache/apk/* && mkdir /run/apache2 && \
ln -s /usr/lib/apache2/ /etc/apache2/modules && \
ln -s /run/apache2 /etc/apache2/run && \
ln -s /var/log/apache2 /etc/apache2/logs 
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.20.0.0/s6-overlay-$ARCH.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-$ARCH.tar.gz -C /
COPY bashrc /root/.bashrc
COPY 000-default.conf /etc/apache2/conf.d
COPY httpd.conf /etc/apache2
COPY php_opcache.ini /etc/php7/conf.d
ENV TZ Europe/Paris
EXPOSE 80 443
ENTRYPOINT ["/init"]
CMD httpd -D FOREGROUND
