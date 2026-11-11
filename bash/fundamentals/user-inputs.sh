#!/bin/bash

greet_user() {
    echo "What is your name?"
    read name
    echo "Hello, $name!"
}

#greet_user

greet() {
    local name

    if [ $# -eq 0 ]; then
        echo "What is your name?"
        read name
    else
        name="$1"
    fi

    echo "Hello, $name!"
}

greet