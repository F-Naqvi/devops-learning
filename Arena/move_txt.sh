#!/bin/bash

source_dir="/Users/faseehnaqvi/devops/Arena"
dest_dir="/Users/faseehnaqvi/devops/Backup"

for file in "$source_dir"/*.txt
do
    if [ -f "$file" ]; then
        cp "$file" "$dest_dir"
    fi
done