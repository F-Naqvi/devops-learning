#!/bin/bash

mkdir -p Arena_Boss
 for (( i=1; i<=5; i++))
 do
    FILE="Arena_Boss/file$i.txt"
    LINES=$((RANDOM % 11 + 10))
    for (( j=1; j<=$LINES; j++ ))
    do
        echo "This is line $j" >> $FILE
    done
done

DIRECTORY="Arena_Boss"

for file in $DIRECTORY/*
do
    if [ -f "$file" ]; then
        size=$(wc -c < "$file")
        echo $size $file
    fi
done | sort -n
echo "Files have been sorted by size."

SEARCH_DIR="Arena_Boss"
DEST_DIR="Victory_Archive"
WORD="Victory"

mkdir -p "Victory_Archive"

for file in "$SEARCH_DIR"/*.txt
do
    if grep -q "$WORD" "$file"; then
        mv "$file" "$DEST_DIR"
        echo "$file contains the word 'Victory' and has been moved to Victory_Archive."
    fi
done
