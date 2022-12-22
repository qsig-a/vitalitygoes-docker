FROM --platform=linux/x86_64 debian:stable-slim

RUN apt update -y
# Vitality GOES Dependencies
RUN apt install -y \
        apache2 \
        php \
        libapache2-mod-php

# GOES Tools Dependencies
RUN apt install -y \
        build-essential \
        cmake \
        git-core \
        libopencv-dev \
        libproj-dev \
        zlib1g-dev \
        librtlsdr-dev \
        libairspy-dev

# Add goestools
RUN git clone --recursive https://github.com/pietern/goestools
WORKDIR /goestools
RUN mkdir build
WORKDIR /goestools/build
RUN cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local
RUN make
RUN make install

# Add vitality-goes
RUN rm -rf /var/www/html
WORKDIR /
RUN git clone https://github.com/JVital2013/vitality-goes
WORKDIR /vitality-goes
RUN cp -r html /var/www/html

# Prep configs
RUN mkdir /goes_config

# Copy run script
COPY run.sh /run.sh

ENTRYPOINT [ "/run.sh" ]