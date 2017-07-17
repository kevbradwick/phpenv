FROM ubuntu:16.10

RUN set -ex; \
    apt-get update && apt-get install -y php php-all-dev php-cli php-common php-curl php-dev \
    php-gd php-mysql php-pgsql php-sqlite3 php-tidy php-xmlrpc php-apcu php-bz2 php-cache \
    php-composer-ca-bundle php-gettext php-http php-imagick php-intl \
    php-json php-json-schema php-log php-mongodb php-phpdbg php-soap php-solr php-uuid \
    php-xdebug php-xml php-yaml php-zip vim-nox

RUN set -ex; \
    apt-get update && apt-get install -y apache2 apache2-bin apache2-dev apache2-utils \
    libapache2-mod-php && service apache2 start

COPY ./docker/20-xdebug.ini /etc/php/7.0/apache2/conf.d/20-xdebug.ini
COPY ./docker/apache/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./docker/utils /opt/utils

RUN set -ex; \
    a2enmod rewrite expires && service apache2 restart

VOLUME "/var/www/html"

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND