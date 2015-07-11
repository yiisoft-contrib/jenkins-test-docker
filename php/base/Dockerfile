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
  DEBIAN_FRONTEND=noninteractive apt-get install -y php5-cli php5-dev php-pear php5-curl

# install composer
RUN \
  cd /usr/local/bin  && \
  curl -sS https://getcomposer.org/installer | php  && \
  ln -s composer.phar composer
RUN \
  composer global require "fxp/composer-asset-plugin:~1.0.0" "phpunit/phpunit"  && \
  ln -s /root/.composer/vendor/bin/phpunit /usr/local/bin/phpunit

# prepare php build
RUN git clone https://github.com/php/php-src /opt/php/php-src
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php5-dev openssl libssl-dev libicu-dev libmcrypt-dev libreadline-dev libbz2-dev libcurl4-openssl-dev libjpeg8-dev libpng12-dev libfreetype6-dev libmm-dev libpq-dev libmagickcore-dev libgraphicsmagick1-dev libmagickwand-dev

# add imagick extension
RUN cd /opt/php/php-src/ext  && \
    pecl download imagick  && \
    mv imagick*.tgz imagick.tgz  && \
    gzip -d < imagick.tgz | tar -xvf -  && \
    mv imagick-* imagick

# add gmagick extension
RUN cd /opt/php/php-src/ext  && \
    pecl download gmagick-1.1.7RC3  && \
    mv gmagick*.tgz gmagick.tgz  && \
    gzip -d < gmagick.tgz | tar -xvf -  && \
    mv gmagick-* gmagick
