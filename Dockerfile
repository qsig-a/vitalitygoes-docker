FROM --platform=linux/x86_64 debian:stable-slim

# Dependencies
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
        libairspy-dev

# Add goestools
RUN git clone --recursive https://github.com/pietern/goestools
WORKDIR /goestools
COPY goestools-patches patches
RUN git apply patches/*.patch && mkdir build
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

# Set localhost
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy run script
COPY run.sh /run.sh

# Remove dev tools
RUN apt purge -y \
        build-essential \
        cmake \
        git-core \
        libopencv-dev \
        libproj-dev \
        zlib1g-dev

RUN apt autoclean

CMD [ "/run.sh" ]
