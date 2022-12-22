#!/bin/bash

set -m

GOESRECV=/goes_config/goesrecv.conf
if [ -f "$FILE" ]; then
    echo "$FILE exists, skipping copy"
else 
    cp /vitality-goes/goestools-conf/goesrecv.conf /goes_config/goesrecv.conf
fi

GOESPROC=/goes_config/goesproc-goesr.conf
if [ -f "$FILE" ]; then
    echo "$FILE exists, skipping copy"
else 
    cp /vitality-goes/goestools-conf/goesrecv.conf /goes_config/goesrecv.conf
fi
echo "Starting goesrecv"
goesrecv -c /goes_config/goesrecv.conf &

echo "Starting goesproc"
goesproc -c /goes_config/goesproc-goesr.conf  --subscribe localhost:5000 > /dev/null &

echo "Starting apache"
service apache2 start &

fg %1