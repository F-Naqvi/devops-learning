#!/bin/bash

filename="$1"

if [ $# -eq 0 ]; then
    echo "File not provided. Enter filename: "
    read filename

    if [ -z "$filename" ]; then
       echo "File not provided!"
       exit 1
    fi
fi

if [ -f "$filename" ]; then
    lines=$(wc -l < "$filename")
    echo "The file has $lines lines."
else
    echo "File not found."
    exit 1
fi