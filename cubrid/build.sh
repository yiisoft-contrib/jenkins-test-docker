#!/bin/sh

if [ "$CUBRID_VERSION" = "9.3" ] ; then
	CUBRID_BUILD=9.3/CUBRID-9.3.2.0016
elif [ "$CUBRID_VERSION" = "9.2" ] ; then
	CUBRID_BUILD=9.2/CUBRID-9.2.20.0003
elif [ "$CUBRID_VERSION" = "8.4" ] ; then
	CUBRID_BUILD=8.4.4/CUBRID-8.4.4.13002
else
	echo "unknown CUBID version, go to http://ftp.cubrid.org/CUBRID_Engine/ and check for the build you need, then edit this file."
	exit 1
fi


if (docker images | grep -P "yiitest/cubrid\s+$CUBRID_VERSION"); then
    echo "docker for CUBRID $CUBRID_VERSION already exists"
else
    echo "building docker for CUBRID $CUBRID_VERSION."
    sed -ri "s/^(ENV CUBRID_VERSION).*/\1 $CUBRID_BUILD/" Dockerfile
    docker build --rm=false -t yiitest/cubrid:$CUBRID_VERSION .
fi
