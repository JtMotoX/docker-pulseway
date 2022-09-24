FROM debian:11-slim as base_image


FROM base_image as downloader
COPY ./pulseway_x64_8.11.0.deb /downloads/pulseway.deb


FROM base_image as final_image

# INSTALL DEPENDENCIES FOR PULSEWAY
RUN apt-get update && \
	apt-get install -y \
		procps \
		wget \
		ca-certificates \
		openssl \
		libidn11 \
		&& \
	rm -rf /var/lib/apt/lists/*

# INSTALL CURL FOR 1PASSWORD INTEGRATION
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# SETUP USER
ARG USER_NAME=appuser
ARG USER_ID=1001
ARG GROUP_NAME=appgroup
ARG GROUP_ID=2001
RUN groupadd -g ${GROUP_ID} -r ${GROUP_NAME} && \
	useradd -u ${USER_ID} -r ${USER_NAME} -g ${GROUP_NAME}

# SETUP SUDO FOR NON-ROOT USER
RUN apt-get update && \
	apt-get install -y \
		sudo \
		&& \
	rm -rf /var/lib/apt/lists/*
RUN echo "Defaults        lecture = never" >>/etc/sudoers.d/suppress_lecture
RUN echo "${USER_NAME} ALL=NOPASSWD:SETENV: /etc/init.d/pulseway start" >>/etc/sudoers.d/sudo_commands

# RUN PULSEWAY INSTALLER FROM DOWNLOADER STAGE
RUN --mount=type=bind,from=downloader,source=/downloads,target=/downloads \
	dpkg -i /downloads/pulseway.deb

# INSTALL envsubst
RUN apt-get update && \
	apt-get install -y gettext-base && \
	rm -rf /var/lib/apt/lists/*

# SET PERMISSIONS FOR NON-ROOT USER
RUN touch /etc/pulseway/config.xml && \
	chmod 777 /etc/pulseway/config.xml

COPY --chmod=755 ./entrypoint.sh /entrypoint.sh

USER ${USER_NAME}

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "run" ]
