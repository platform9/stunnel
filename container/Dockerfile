FROM ubuntu:xenial
ARG STUNNEL_VERSION
RUN apt-get -y update && apt-get -y install wget tar gcc libssl-dev patch make
WORKDIR /root

RUN wget https://www.stunnel.org/downloads/stunnel-$STUNNEL_VERSION.tar.gz
RUN tar xf stunnel-*.gz
ADD pf9.patch /root/
RUN patch -p0 < pf9.patch
RUN cd stunnel-$STUNNEL_VERSION && ./configure && make && mv src/stunnel /usr/local/bin && rm -rf stunnel*

# configure libkeepalive and enable it system-wide
RUN wget http://prdownloads.sourceforge.net/libkeepalive/libkeepalive-0.3.tar.gz
RUN tar xf libkeepalive-0.3.tar.gz
RUN cd libkeepalive-0.3 && make && mv libkeepalive.so /root
RUN echo /root/libkeepalive.so > /etc/ld.so.preload
