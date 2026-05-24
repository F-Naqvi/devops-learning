#!/bin/bash

mkdir /Users/faseehnaqvi/devops/Arena/Battlefield
cd /Users/faseehnaqvi/devops/Arena/Battlefield
touch knight.txt sorcerer.txt rogue.txt

if [ -f "knight.txt" ]; then
    echo "File exists!"
    mkdir "/Users/faseehnaqvi/devops/Arena/Archive"
    mv knight.txt /Users/faseehnaqvi/devops/Arena/Archive
    echo "File moved!"
else
    echo "File does not exist!"
fi

echo "Contents of Battlefield:"
ls /Users/faseehnaqvi/devops/Arena/Battlefield

echo "Contents of Archive:"
ls /Users/faseehnaqvi/devops/Arena/Archive