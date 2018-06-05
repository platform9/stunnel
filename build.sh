#!/usr/bin/env bash

set -e
STUNNEL_RELEASE=${STUNNEL_RELEASE:-"stunnel-5.46"}
STUNNEL_URL=${STUNNEL_URL:-"https://www.stunnel.org/downloads/${STUNNEL_RELEASE}.tar.gz"}

wget ${STUNNEL_URL}
tar xf stunnel-*.gz
patch -p0 < pf9.patch
mkdir build
cd ${STUNNEL_RELEASE}
./configure
make
mv src/stunnel ../build


