FROM phusion/baseimage:0.9.16
MAINTAINER Jos van der Til <jos@vandertil.net>

ENV HOME /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
#ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen en_US.UTF-8

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
    && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache \
    && add-apt-repository ppa:webupd8team/java \
    && apt-get update -q \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -q -y oracle-java8-installer \
    && apt-get clean \
    && rm -rf /build \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get remove -y x11-common

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
