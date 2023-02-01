FROM debian:stable-slim

#Copy in all files
COPY configs /configs
COPY run.sh /run.sh

# Dependencies, build goestools, then remove build tools
RUN apt update -y && apt install -y \
        apache2 \
        php \
        libapache2-mod-php \
        build-essential \
        cmake \
        git-core \
        libopencv-dev \
        libproj-dev \
        zlib1g-dev \
        librtlsdr-dev \
        libairspy-dev && \
    git clone --recursive https://github.com/pietern/goestools && \
    cd /goestools && \
    git checkout 865e5c7 && \
    git apply /configs/goestools-patches/*.patch && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make && \
    make install && \
    cd / && \
    rm -rf /goestools && \
    apt purge -y \
        build-essential \
        cmake \
        git-core \
        libopencv-dev \
        libproj-dev \
        zlib1g-dev && \
        apt autoclean


# Add vitality-goes
RUN rm -rf /var/www/html && \
    git clone https://github.com/JVital2013/vitality-goes && \
    cd vitality-goes && \
    git checkout v1.4.1 && \
    cp -r html /var/www/html && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    chmod +x /run.sh

ENV SATELLITE goes16
CMD [ "/run.sh" ]
