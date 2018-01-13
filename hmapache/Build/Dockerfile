FROM debian:stretch-slim
RUN apt-get update &&  apt-get install -y apt-utils vim apache2 libapache2-mod-php \
 php-gd php-json php-mysql php-curl \
 php-mbstring php-intl php-mcrypt \
 php-imagick php-xml php-zip php-sqlite3 sqlite3 \
 && rm -rf /var/lib/apt/lists/*
COPY bashrc /root/.bashrc
COPY 000-default.conf /etc/apache2/sites-available/
EXPOSE 80 443
CMD /usr/sbin/apachectl -D FOREGROUND
