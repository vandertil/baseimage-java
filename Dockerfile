FROM phusion/baseimage:0.9.16
MAINTAINER Jos van der Til <jos@vandertil.net>

ENV DEBIAN_FRONTEND noninteractive

# Speed up APT
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup ; echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

RUN add-apt-repository ppa:webupd8team/java ; apt-get update -qq

# auto accept oracle jdk license
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

RUN apt-get install -q -y oracle-java8-installer

