#!/bin/bash

: 'read_file(){
    local file_path="$1"

    while IFS= read -r line; do
        echo "$line"
    done < "$file_path"
}

read_file "./break.sh"'

process_file(){
    local file_path="$1"

    cat "$file_path" | while IFS= read -r line; do
        echo "Processing line: $line"
    done
}

process_file "./break.sh"