#
# Dockerfile for php debian environment
#

FROM yiitest/php-base:latest

ENV PHP_VERSION master
ENV PHP_CONFIG=""

# check out the desired version
RUN cd /opt/php/php-src  && \
    git checkout $PHP_VERSION

# build php and switch php version
RUN cd /opt/php/php-src  && \
    (rm configure || echo "no configure")  && \
    ./buildconf --force  && \
    ./configure --prefix=/opt/php/php-dist/$PHP_VERSION-custom --with-config-file-path=/opt/php/php-dist/$PHP_VERSION-custom/etc $PHP_CONFIG  && \
    make && make install  && \
    switchphp $PHP_VERSION-custom

ADD php.ini /opt/php/php-dist/$PHP_VERSION-custom/etc/php.ini

# Define mountable directories.
VOLUME ["/opt/test"]
WORKDIR /opt/test
