#!/bin/sh

if [ "$CUBRID_PDO_VERSION" = "9.3" ] ; then
	CUBRID_PDO_BUILD=9.3.0.0001
elif [ "$CUBRID_PDO_VERSION" = "9.2" ] ; then
	CUBRID_PDO_BUILD=9.2.0.0001
elif [ "$CUBRID_PDO_VERSION" = "8.4" ] ; then
	CUBRID_PDO_BUILD=8.4.3.0001
else
	echo "unknown CUBID PDO version."
	exit 1
fi

echo "CUBRID PDO BUILD: $CUBRID_PDO_BUILD"


if (docker images | grep -P "yiitest/php-cubrid\s+$PHP_VERSION-$CUBRID_PDO_VERSION"); then
    echo "docker for PHP CUBRID PDO $PHP_VERSION-$CUBRID_PDO_VERSION already exists"
else
    echo "building docker for CUBRID PDO $PHP_VERSION-$CUBRID_PDO_VERSION."
    sed -ri "s/^(FROM yiitest\/php:).*/\1$PHP_VERSION/" Dockerfile
    sed -ri "s/^(ENV PHP_VERSION).*/\1 $PHP_VERSION/" Dockerfile
    sed -ri "s/^(ENV CUBRID_PDO_VERSION).*/\1 $CUBRID_PDO_BUILD/" Dockerfile
    docker build --rm=false -t yiitest/php-cubrid:$PHP_VERSION-$CUBRID_PDO_VERSION .
fi
