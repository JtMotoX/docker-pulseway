FROM alpine:latest as downloader

ARG TARGETPLATFORM

RUN apk add --no-cache curl dpkg

WORKDIR /downloads

# RUN PULSEWAY INSTALLER FROM DOWNLOADER STAGE
RUN case "${TARGETPLATFORM}" in \
		"linux/amd64") deb_arch="pulseway_x64";; \
		"linux/386") deb_arch="pulseway_x86";; \
		"linux/arm/v7") deb_arch="pulseway_armhf";; \
		"linux/arm64") deb_arch="pulseway_arm64";; \
		*) echo "Unsupported platform: ${TARGETPLATFORM}"; exit 1;; \
	esac && \
    curl "https://www.pulseway.com/download/${deb_arch}.deb" --output "pulseway.deb" && \
    dpkg-deb -f "pulseway.deb" Version >version.txt

RUN cat version.txt

####################
FROM busybox:latest
WORKDIR /downloads
COPY --from=downloader /downloads .
