#!/bin/bash

length=$1
width=$2

area=$((length * width))
perimeter=$((2 *(length + width)))

echo "Area: $area"
echo "Perimeter: $perimeter"
