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
  DEBIAN_FRONTEND=noninteractive apt-get install -y git curl build-essential autoconf bison re2c libxml2-dev

# install php5-cli and php-dev to have php enabled by default, switchphp can be used to switch to a self-compiled version
ADD switchphp /usr/bin/switchphp
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install -y php5-cli php5-dev

# install composer
RUN \
  cd /usr/local/bin && \
  curl -sS https://getcomposer.org/installer | php && \
  ln -s composer.phar composer

ENV PHP_VERSION master
ENV PHP_CONFIG 

# build php and switch
RUN git clone https://github.com/php/php-src /opt/php/php-src
RUN git checkout $PHP_VERSION  && \
    ./buildconf -f  && \
    ./configure --prefix=/opt/php/php-dist/$PHP_VERSION-custom $PHP_CONFIG  && \
    make && make install  && \
    switchphp $PHP_VERSION-custom

# Define mountable directories.
VOLUME ["/opt/test"]
WORKDIR /opt/test
