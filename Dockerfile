# syntax = docker/dockerfile:1

# Github Containers
LABEL org.opencontainers.image.source=https://github.com/swobspace/cups-pdf-container
LABEL org.opencontainers.image.description="CUPS-PDF on Ubuntu"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.documentation=https://github.com/swobspace/cups-pdf-container

ARG UBUNTU_VERSION=24.04
FROM registry.docker.com/library/ubuntu:$UBUNTU_VERSION as base

# Install packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y xinetd cups-bsd printer-driver-cups-pdf 

# RUN getent group admin &>/dev/null || groupadd lpadmin
RUN useradd admin --system -G root,lpadmin --no-create-home

COPY cupsd.conf /etc/cups/.
COPY cups-pdf.conf /etc/cups/.
COPY xinetd-cups.conf /etc/xinetd.d/cups
COPY start-xinetd.sh start-xinetd.sh
COPY start-cupsd.sh start-cupsd.sh
COPY start-all.sh start-all.sh

CMD ["./start-all.sh"]

