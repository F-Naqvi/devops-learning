#!/bin/bash

DIRECTORY="/Users/faseehnaqvi/devops/Arena"
SEARCH_TERM="bash"

if [ ! -d "$DIRECTORY" ]; then
    echo "Directory does not exist!"
    exit 1
fi

grep -l "$SEARCH_TERM" "$DIRECTORY"/*.log > search.txt

cat search.txt

