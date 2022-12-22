#!/bin/bash

set -m

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