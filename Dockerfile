FROM phusion/baseimage:0.9.19
MAINTAINER Jos van der Til <jos@vandertil.net>

ENV HOME /root
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN locale-gen en_US.UTF-8

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \
    && echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache \
    && add-apt-repository ppa:webupd8team/java \
    && apt-get update -q \
    && apt-get upgrade -q -y \
    && echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections \
    && apt-get install -q -y --no-install-recommends oracle-java8-installer ca-certificates apt-transport-https \
    && apt-get clean \
    && rm -rf /build \
    && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && curl -O https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.der \
    && curl -O https://letsencrypt.org/certs/lets-encrypt-x2-cross-signed.der \
    && curl -O https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.der \
    && curl -O https://letsencrypt.org/certs/lets-encrypt-x4-cross-signed.der \
    && /usr/lib/jvm/java-8-oracle/jre/bin/keytool -import -keystore /usr/lib/jvm/java-8-oracle/jre/lib/security/cacerts -storepass changeit -noprompt -trustcacerts -alias letsencryptauthorityx1 -file lets-encrypt-x1-cross-signed.der \
    && /usr/lib/jvm/java-8-oracle/jre/bin/keytool -import -keystore /usr/lib/jvm/java-8-oracle/jre/lib/security/cacerts -storepass changeit -noprompt -trustcacerts -alias letsencryptauthorityx2 -file lets-encrypt-x2-cross-signed.der \
    && /usr/lib/jvm/java-8-oracle/jre/bin/keytool -import -keystore /usr/lib/jvm/java-8-oracle/jre/lib/security/cacerts -storepass changeit -noprompt -trustcacerts -alias letsencryptauthorityx3 -file lets-encrypt-x3-cross-signed.der \
    && /usr/lib/jvm/java-8-oracle/jre/bin/keytool -import -keystore /usr/lib/jvm/java-8-oracle/jre/lib/security/cacerts -storepass changeit -noprompt -trustcacerts -alias letsencryptauthorityx4 -file lets-encrypt-x4-cross-signed.der \
    && rm -f *.der

ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
