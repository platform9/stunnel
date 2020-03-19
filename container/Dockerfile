FROM debian
RUN apt-get -y update && apt-get -y install wget tar gcc libssl-dev patch make
WORKDIR /root

RUN wget https://www.stunnel.org/downloads/stunnel-5.46.tar.gz
RUN tar xf stunnel-*.gz
ADD pf9.patch /root/
RUN patch -p0 < pf9.patch
RUN cd stunnel-5.46 && ./configure && make && mv src/stunnel /usr/local/bin && rm -rf stunnel*
