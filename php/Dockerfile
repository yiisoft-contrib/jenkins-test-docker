#
# Dockerfile for php debian environment
#

FROM yiitest/php-base:latest

ENV PHP_VERSION master
ENV PHP_CONFIG="--with-config-file-path=/opt/php/php-dist/$PHP_VERSION-custom/etc --with-openssl --without-pear --with-pcre-regex --with-openssl --with-kerberos --with-zlib --with-bz2 --enable-zip --enable-bcmath --with-mcrypt --with-curl --enable-ftp --with-gd --enable-exif --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-intl --enable-mbstring --with-gettext --with-mysqli --with-pdo-mysql --with-mm --enable-soap --with-readline --enable-opcache --with-pdo-mysql --with-pdo-sqlite --with-pdo-pgsql --with-imagick --with-gmagick"

# check out the desired version
RUN cd /opt/php/php-src  && \
    git checkout $PHP_VERSION

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
