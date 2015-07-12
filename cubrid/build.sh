#!/bin/sh

if (docker images | grep -P "yiitest/cubrid\s+$CUBRID_VERSION"); then
    echo "docker for CUBRID $CUBRID_VERSION already exists"
else
    echo "building docker for CUBRID $CUBRID_VERSION."
    sed -ri "s/^(ENV CUBRID_VERSION).*/\1 $CUBRID_VERSION/" Dockerfile
    docker build --rm=false -t yiitest/cubrid:$CUBRID_VERSION .
fi
