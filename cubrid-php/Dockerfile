FROM yiitest/php:master

ENV PHP_VERSION master
ENV CUBRID_PDO_VERSION 9.3.0.0001



RUN \
  mkdir -p /opt/cubrid  && \
  cd /opt/cubrid  && \
  curl -SL "http://pecl.php.net/get/PDO_CUBRID-$CUBRID_PDO_VERSION.tgz" -o PDO_CUBRID.tgz  && \
  tar -zxf PDO_CUBRID.tgz  && \
  cd PDO_CUBRID-$CUBRID_PDO_VERSION  && \
  phpize  && \
  ./configure --prefix=/opt/cubrid/PDO_CUBRID-$CUBRID_PDO_VERSION  && \
  make  && \
  echo "extension=/opt/cubrid/PDO_CUBRID-$CUBRID_PDO_VERSION/modules/pdo_cubrid.so" >> /opt/php/php-dist/$PHP_VERSION-custom/etc/php.ini
