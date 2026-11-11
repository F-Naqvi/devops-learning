#!/bin/bash

echo "Enter filename."
read filename

if [ $# -eq 0 ]; then
    echo "No file provided."
    exit 1
fi

if [ -f "$filename" ]; then
    lines=$(wc -l < "$filename")
    echo "The file has $lines lines."
else
    echo "File not found"
fi