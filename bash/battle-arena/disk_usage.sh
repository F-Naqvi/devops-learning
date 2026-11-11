#!/bin/bash

DIRECTORY="$1"
THRESHOLD=1


if [ $# -eq 0 ]; then
    echo "Please enter directory name:"
    read DIRECTORY

    if [ -z "$DIRECTORY" ]; then
        echo "No directory provided."
        exit 1
    fi
fi

USAGE=$( du -sm "$DIRECTORY" | awk '{print $1}')

echo "$USAGE"

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Warning! Threshild for disk usage has been exceeded!"
else 
    echo "Disk usage for $DIRECTORY is at acceptable usage!"
fi

