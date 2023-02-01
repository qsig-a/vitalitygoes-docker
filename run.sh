#!/bin/bash

set -m

# Set up image directory
if [ -d "/images" ]
then
    echo "Directory /images exists" 
else
    echo "Creating /images..."
    mkdir /images
fi

# Set up goestools config directory
if [ -d "/goestools-config" ]
then
    echo "Directory /goestools-config exists" 
else
    echo "Creating /goestools-config..."
    mkdir /goestools-config
fi

# Set up Vitality GOES config
if [ -f "/var/www/html/config/config.ini" ]
then
	echo "Vitality GOES is already configured"
else
	echo "Initializing Vitality GOES configuration..."
	cp /vitality-goes/configs/goestools-$SATELLITE/{config.ini,abi.ini,l2.ini,meso.ini,nws.ini,emwin.ini} /var/www/html/config/
	sed -i "s/\/path\/to\/goestoolsdata/\/images/g; s/;adminPath/adminPath/g" /var/www/html/config/config.ini
fi

# Set up goesrecv
GOESRECV=/goestools-config/goesrecv.conf
if [ -f "$GOESRECV" ]
then
    echo "$GOESRECV exists"
else 
	echo "Initializing $GOESRECV..."
    cp /vitality-goes/configs/goesrecv.conf $GOESRECV
fi

# Set up goesproc
GOESPROC=/goestools-config/goesproc-goesr.conf
if [ -f "$GOESPROC" ]
then
    echo "$GOESPROC exists"
else
	echo "Initializing $GOESPROC..."
    cp /vitality-goes/configs/goesproc-goesr.conf $GOESPROC
	sed -i "s/\/path\/to\/goestoolsrepo/\/images/g" $GOESPROC
fi

echo "Starting apache"
service apache2 start &

echo "Starting goesrecv"
goesrecv -c $GOESRECV &

echo "Starting goesproc"
goesproc -c $GOESPROC --subscribe tcp://localhost:5004 > /dev/null &

fg %1