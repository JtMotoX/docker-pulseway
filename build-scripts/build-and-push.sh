#!/bin/sh

set -e
cd "$(dirname "$0")"
cd ..

if [ "$1" != "" ]; then
	PULSEWAY_VERSION_ARG="--build-arg PULSEWAY_VERSION=$1"
fi

# CREATE MULTI-ARCH BUILDER IF NOT EXISTS
buildx_builder="pulseway-builder"
if ! docker buildx ls --format "{{.Name}}" | grep "^${buildx_builder}$" >/dev/null 2>&1; then
	docker buildx install
	docker buildx create --name ${buildx_builder}
fi

set -x
docker buildx build --builder ${buildx_builder} --platform linux/386,linux/amd64,linux/arm/v7,linux/arm64 -t jtmotox/pulseway:9.5.0 -t jtmotox/pulseway:latest --push ${PULSEWAY_VERSION_ARG} ./build
{ set +x; } 2>/dev/null
