#
# redis Dockerfile
#

# Pull base image.
# https://registry.hub.docker.com/_/debian/
FROM debian:wheezy

ENV CUBRID_VERSION 9.3.0/CUBRID-9.3.0.0206

RUN \
  apt-get update  && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y wget curl

RUN \
  mkdir -p /opt/cubrid  && \
  cd /opt/cubrid  && \
  curl -SL "http://ftp.cubrid.org/CUBRID_Engine/$CUBRID_VERSION-linux.x86_64.tar.gz" -o cubrid.tar.gz  && \
  tar xzf cubrid.tar.gz

ENV CUBRID /opt/cubrid/CUBRID
ENV CUBRID_DATABASES=$CUBRID/databases
ENV CUBRID_LANG=en_US

ADD run.sh /opt/cubrid/run.sh

EXPOSE 33000
WORKDIR /opt/cubrid
CMD [ "/opt/cubrid/run.sh" ]
