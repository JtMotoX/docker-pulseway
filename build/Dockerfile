# BUILD ARGS
ARG PULSEWAY_DEB="pulseway_x64_9.5.0.deb"

# BASE IMAGE
FROM debian:12-slim

ARG PULSEWAY_DEB

# INSTALL DEPENDENCIES FOR PULSEWAY
RUN apt-get update && \
	apt-get install -y \
		procps \
		wget \
		ca-certificates \
		openssl \
		libidn12 \
		dmidecode \
		&& \
	rm -rf /var/lib/apt/lists/*

# INSTALL CURL FOR 1PASSWORD INTEGRATION
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# SETUP USER
ARG USER_NAME=appuser
ARG USER_ID=9001
RUN useradd -u ${USER_ID} -r ${USER_NAME}

# SETUP SUDO FOR NON-ROOT USER
RUN apt-get update && \
	apt-get install -y \
		sudo \
		&& \
	rm -rf /var/lib/apt/lists/*
RUN echo "Defaults        lecture = never" >>/etc/sudoers.d/suppress_lecture
RUN echo "${USER_NAME} ALL=NOPASSWD:SETENV: /etc/init.d/pulseway start" >>/etc/sudoers.d/sudo_commands

# RUN PULSEWAY INSTALLER FROM DOWNLOADER STAGE
RUN --mount=type=bind,source=.,target=/build \
	dpkg -i "/build/${PULSEWAY_DEB}"

# INSTALL envsubst
RUN apt-get update && \
	apt-get install -y gettext-base && \
	rm -rf /var/lib/apt/lists/*

# SET PERMISSIONS FOR NON-ROOT USER
RUN touch /etc/pulseway/config.xml && \
	chmod 777 /etc/pulseway/config.xml

COPY --chmod=755 ./entrypoint.sh /entrypoint.sh

USER ${USER_ID}:${USER_ID}

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "run" ]
