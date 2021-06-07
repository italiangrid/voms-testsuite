#!/usr/bin/env bash

VERSION=${1:-latest}

# TODO get the latest version following https://curl.se/download.html
#   hardcode it for the moment
if [ ${VERSION} = "latest" ]; then
    VERSION="7.77.0"
fi

TMPDIR=$(mktemp -d)
echo $TMPDIR

wget https://curl.se/download/curl-${VERSION}.tar.gz -O - | tar xz --directory=${TMPDIR}

SOURCE_DIR=${TMPDIR}/curl-${VERSION}

cd ${SOURCE_DIR}
./configure --with-ssl --disable-dependency-tracking
make
make install
cd -

rm -rf ${SOURCE_DIR}
rmdir ${TMPDIR}
