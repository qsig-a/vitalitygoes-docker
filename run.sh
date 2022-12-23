#!/bin/bash

set -m

if [ -d "/images" ] 
then
    echo "Directory /images exists." 
else
    echo "Directory /images does not exist."
    mkdir /images
fi


if [ -d "/goes_config" ] 
then
    echo "Directory /goes_config exists." 
else
    echo "Directory /goes_config does not exist."
    mkdir /goes_config
fi

GOESRECV=/goes_config/goesrecv.conf
if [ -f "$GOESRECV" ]; then
    echo "$GOESRECV exists, skipping copy"
else 
    cp /vitality-goes/goestools-conf/goesrecv.conf /goes_config/goesrecv.conf
fi

GOESPROC=/goes_config/goesproc-goesr.conf
if [ -f "$GOESPROC" ]; then
    echo "$GOESPROC exists, skipping copy"
else 
    cp /vitality-goes/goestools-conf/goesproc-goesr.conf /goes_config/goesproc-goesr.conf
fi

echo "Starting goesrecv"
goesrecv -c /goes_config/goesrecv.conf &

echo "Starting goesproc"
goesproc  -c /goes_config/goesproc-goesr.conf --subscribe tcp://localhost:5004 > /dev/null &

echo "Starting apache"
service apache2 start &

fg %1