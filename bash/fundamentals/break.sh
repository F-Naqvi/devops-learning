#!/bin/bash

count-1

while true
do 
    echo "Count: $count"
    (( count+=1 ))
    if [ $count -eq 4 ]; then
        break
    fi
done