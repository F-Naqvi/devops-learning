#!/bin/bash

: 'command -v 2> /dev/null

if [ $? -eq 0 ]; then
    echo "Git is not installed."
    exit 1
else
    echo "Git is installed."
fi

set -e

echo "Before the script"

nonexistentcommand

echo "After the script"

set -u

echo "The value of X is: $X"

set -u

X=10
Y=20
Z=$(( X + Y + W))
echo "Z equals: $Z"

set -x

echo "This is a test."
X=10
echo "The value of X is: $X"

set -x

echo "Starting the script"
X=10
Y=20
Z=$(( X + Y ))
echo "The value of Z is: $Z"'

set -eux

echo "This is a test."
X=10
echo "The value of X is: $X"

nonexistentcommand







