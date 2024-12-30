# syntax=docker/dockerfile:1
FROM ubuntu:latest

# the following envars must be set
ENV PUID=""
ENV PGID=""

ENV LANG C.UTF-8
ENV TZ America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Get Ubuntu packages
RUN apt-get update && apt-get install -y  --no-install-recommends \
    curl \
    wget \
    python3 \
    git \
    ffmpeg \
    ca-certificates

RUN wget https://github.com/badaix/snapcast/releases/download/v0.29.0/snapserver_0.29.0-1_arm64_bookworm.deb
RUN apt install ./snapserver_0.29.0-1_arm64_bookworm.deb

# clean up to minimize image size
RUN rm -rf /var/cache/apt/archives && rm -rf /usr/share/doc && rm -rf /usr/share/man

# Get librespot, use prebuilt binary to minimize image size
# saves ~2GB of image size, and a ton of time
RUN wget https://github.com/SolidHal/librespot/releases/download/v0.6.0-passthrough/librespot-release-$(arch) -O /usr/bin/librespot && chmod +x /usr/bin/librespot

# create the user and group
RUN useradd -u 911 -U -d /config -s /bin/false abc
RUN usermod -G users abc
RUN mkdir -p /config

COPY entrypoint.sh /entrypoint.sh

EXPOSE 1704/tcp 1705/tcp
ENTRYPOINT ["/entrypoint.sh"]
