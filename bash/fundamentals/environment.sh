#!/bin/bash

: 'my_home="$HOME"
my_user="$USER"
my_os="$OSTYPE"

echo "Home Directory: $my_home"
echo "Home Directory: $my_user"
echo "OS Type: $my_os"'

echo "Username: $LOGNAME"
echo "Shell: $SHELL"
echo "Current directory: $PWD"

echo "Executable paths: $PATH"
echo "Default language: $LANG"
