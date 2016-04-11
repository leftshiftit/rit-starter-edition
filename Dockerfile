FROM ubuntu:14.04
MAINTAINER John Harris <jharris@leftshiftit.com>

# Set environment variables for better re-use later on
ENV USERNAME rit
ENV HOME /home/${USERNAME}
ENV WORKDIR /opt
ENV RIT_VERSION_FILE ritse.linux.x86_64_9.0.0.v20160302_1549.zip

WORKDIR ${WORKDIR}

# Install relevant packages to make X11 forwarding work for the UI
RUN apt-get update && \
    apt-get install --no-install-recommends -y libxext-dev libxrender-dev libxtst-dev libxft2 unzip wget && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

# Add & configure the 'rit' user
RUN useradd -m $USERNAME && \
    echo "${USERNAME}:${USERNAME}" | chpasswd && \
    usermod --shell /bin/bash ${USERNAME} && \
    usermod -aG sudo ${USERNAME} && \
    echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${USERNAME} && \
    chmod 0440 /etc/sudoers.d/${USERNAME} && \
    # Replace 1000 with your user/group id, this is required for X11 forwarding to work \
    usermod  --uid ${UID:-1000} ${USERNAME} && \
    groupmod --gid ${GID:-1000} ${USERNAME} && \
    chown -R ${USERNAME}:${USERNAME} ${WORKDIR}

USER ${USERNAME}

# Grab the software from IBM's DeveloperWorks website
RUN wget "ftp://public.dhe.ibm.com/software/spcn/continuoustest/${RIT_VERSION_FILE}" && \
    unzip "${RIT_VERSION_FILE}" && \
    rm "${RIT_VERSION_FILE}"

WORKDIR ${WORKDIR}/IntegrationTester

ENTRYPOINT ["./IntegrationTester"]