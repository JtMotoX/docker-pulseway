#!/bin/bash

set -e

cd "$(dirname "$0")"
cd build
docker run --rm -v "$(pwd):/mount" -e UID="$(id -u)" -e GID="$(id -g)" alpine sh -c 'apk add curl dpkg && curl https://www.pulseway.com/download/pulseway_x64.deb --output pulseway_x64.deb && VERSION="$(dpkg-deb -f pulseway_x64.deb Version)" && FILENAME="pulseway_x64_${VERSION}.deb" && FILEPATH="/mount/${FILENAME}" && if test -f "${FILEPATH}"; then { echo "Version ${VERSION} already exists"; } else { echo "Downloaded new version ${VERSION}" && chown "${UID}:${GID}" pulseway_x64.deb && mv pulseway_x64.deb "/mount/pulseway_x64_${VERSION}.deb"; } fi'
pwd
ls -l pulseway*.deb
