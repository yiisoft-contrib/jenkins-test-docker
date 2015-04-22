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

# TODO install php and switch

# Define mountable directories.
VOLUME ["/opt/test"]
WORKDIR /opt/test
