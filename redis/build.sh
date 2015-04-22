#!/bin/sh

echo "building docker for redis $REDIS_VERSION."
sed -ri "s/^(ENV REDIS_VERSION).*/\1 $REDIS_VERSION/" Dockerfile
docker build --rm=false -t yiitest/redis:$REDIS_VERSION .

