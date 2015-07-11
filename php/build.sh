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
    echo "building docker for php $PHP_VERSION."
    sed -ri "s/^(ENV PHP_VERSION).*/\1 $PHP_VERSION/" Dockerfile
    docker build --rm=false -t yiitest/php:$PHP_VERSION .
fi
