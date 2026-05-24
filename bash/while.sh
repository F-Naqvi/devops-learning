#!/bin/bash

count=8

while [ $count -le 10 ]
do
    echo "Count: $count"
    ((count+=1))
done