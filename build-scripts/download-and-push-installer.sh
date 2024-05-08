#!/bin/sh

set -e
cd "$(dirname "$0")"
cd ../

# CREATE MULTI-ARCH BUILDER IF NOT EXISTS
buildx_builder="pulseway-builder"
if ! docker buildx ls --format "{{.Name}}" | grep "^${buildx_builder}$" >/dev/null 2>&1; then
	docker buildx install
	docker buildx create --name ${buildx_builder}
fi

# BUILD HOST ARCH IMAGE AND EXTRACT VERSION
docker buildx build --builder ${buildx_builder} -t pulseway-downloads --load ./build-pulseway-downloader
pulseway_version="$(docker run --rm -it pulseway-downloads sh -c 'cat version.txt' | tr -d '\n' | tr -d '\r')"
echo "pulseway_version: ${pulseway_version}"

# BUILD MULTI-ARCH IMAGE AND PUSH TO DOCKER HUB
set -x
docker buildx build --builder ${buildx_builder} --platform linux/386,linux/amd64,linux/arm/v7,linux/arm64 -t jtmotox/pulseway-downloads:${pulseway_version} -t jtmotox/pulseway-downloads:latest --push ./build-pulseway-downloader
{ set +x; } 2>/dev/null
