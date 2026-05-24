#!/bin/bash

hello_world() {
    echo "Hello World!"
}

greet_person() {
    local name="$1"
    echo "Hello, $name!"
}

greet_person "Faseeh"
greet_person "Sam"