#!/bin/bash

: 'write_to_file(){

    local file_path="$1"
    local data="$2"

    echo "$data" > "$file_path"
}

write_to_file "read.txt" "Hello World!"

calculate_md5sum(){
    local file_path="$1"
    md5sum "$file_path"
}

calculate_md5sum "read.txt"'


compare_checksums(){
    local checksum1="$1"
    local checksum2="$2"

    if [[ "$checksum1" == "$checksum2" ]]; then
        echo "Checksums match."
    else
        echo "Checksums do not match. File integrity compromised."
    fi
}

compare_checksums "123" "123"