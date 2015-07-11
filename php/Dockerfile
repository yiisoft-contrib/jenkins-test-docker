#
# Dockerfile for php debian environment
#

# Pull base image.
# https://registry.hub.docker.com/_/debian/
FROM debian:wheezy

# install make, gcc, git
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y git curl vim build-essential pkg-config autoconf bison re2c libxml2-dev

# install php5-cli and php-dev to have php enabled by default, switchphp can be used to switch to a self-compiled version
ADD switchphp /usr/bin/switchphp
RUN \
  chmod +x /usr/bin/switchphp  && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y php5-cli php5-dev php5-curl

# install composer
RUN \
  cd /usr/local/bin  && \
  curl -sS https://getcomposer.org/installer | php  && \
  ln -s composer.phar composer
RUN \
  composer global require "fxp/composer-asset-plugin:~1.0.0" "phpunit/phpunit"  && \
  ln -s /root/.composer/vendor/bin/phpunit /usr/local/bin/phpunit


ENV PHP_VERSION master
ENV PHP_CONFIG="--with-config-file-path=/opt/php/php-dist/$PHP_VERSION-custom/etc --with-openssl --without-pear --with-pcre-regex --with-openssl --with-kerberos --with-zlib --with-bz2 --enable-zip --enable-bcmath --with-mcrypt --with-curl --enable-ftp --with-gd --enable-exif --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-intl --enable-mbstring --with-gettext --with-mysqli --with-pdo-mysql --with-mm --enable-soap --with-readline --enable-opcache --with-pdo-mysql --with-pdo-sqlite --with-pdo-pgsql --with-imagick --with-gmagick"

# prepare php build
RUN git clone https://github.com/php/php-src /opt/php/php-src
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php5-dev openssl libssl-dev libicu-dev libmcrypt-dev libreadline-dev libbz2-dev libcurl4-openssl-dev libjpeg8-dev libpng12-dev libfreetype6-dev libmm-dev libpq-dev libmagickcore-dev libgraphicsmagick1-dev
RUN cd /opt/php/php-src  && \
    git checkout $PHP_VERSION

# add imagick extension
RUN cd /opt/php/php-src/ext  && \
    pecl download imagick  && \
    mv imagick*.tgz imagick.tgz  && \
    gzip -d < imagick.tgz | tar -xvf -  && \
    mv imagick-* imagick

# add gmagick extension
RUN cd /opt/php/php-src/ext  && \
    pecl download gmagick  && \
    mv gmagick*.tgz gmagick.tgz  && \
    gzip -d < gmagick.tgz | tar -xvf -  && \
    mv gmagick-* gmagick

# build php and switch php version
RUN cd /opt/php/php-src  && \
    rm configure  && \
    ./buildconf --force  && \
    ./configure --prefix=/opt/php/php-dist/$PHP_VERSION-custom $PHP_CONFIG  && \
    make && make install  && \
    switchphp $PHP_VERSION-custom

ADD php.ini /opt/php/php-dist/$PHP_VERSION-custom/etc/php.ini

# Define mountable directories.
VOLUME ["/opt/test"]
WORKDIR /opt/test
