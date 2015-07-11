#!/bin/sh -e

if (docker images | grep -P "yiitest/php-base\s+latest"); then
    echo "base docker image for php already exists"
else
    echo "building base docker image for php."
    docker build --rm=true -t yiitest/php-base:latest base
fi

if (docker images | grep -P "yiitest/php\s+$PHP_VERSION"); then
    echo "docker for php $PHP_VERSION already exists"
else
    if [ "$_PHP_VERSION" == "master" ] ; then
        PHP_CONFIG="--with-openssl --without-pear --with-pcre-regex --with-openssl --with-kerberos --with-zlib --with-bz2 --enable-zip --enable-bcmath --with-mcrypt --with-curl --enable-ftp --with-gd --enable-exif --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-intl --enable-mbstring --with-gettext --with-mysqli --with-pdo-mysql --with-mm --enable-soap --with-readline --enable-opcache --with-pdo-mysql --with-pdo-sqlite --with-pdo-pgsql --with-imagick"
       # exclude --with-gmagick which does not compile on php7 https://bugs.php.net/bug.php?id=70049
    else
        PHP_CONFIG="--with-openssl --without-pear --with-pcre-regex --with-openssl --with-kerberos --with-zlib --with-bz2 --enable-zip --enable-bcmath --with-mcrypt --with-curl --enable-ftp --with-gd --enable-exif --with-jpeg-dir --with-png-dir --with-freetype-dir --enable-intl --enable-mbstring --with-gettext --with-mysqli --with-pdo-mysql --with-mm --enable-soap --with-readline --enable-opcache --with-pdo-mysql --with-pdo-sqlite --with-pdo-pgsql --with-imagick --with-gmagick"
    fi

    echo "building docker for php $PHP_VERSION."
    sed -ri "s/^(ENV PHP_VERSION).*/\1 $PHP_VERSION/" Dockerfile
    sed -ri "s/^(ENV PHP_CONFIG).*/\1 $PHP_CONFIG/" Dockerfile
    docker build --rm=false -t yiitest/php:$PHP_VERSION .
fi
