#!/bin/bash

CONFIG_FILE="settings.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "The configuration file does not exist"
    exit 1
fi

while IFS="=" read -r key value; do
    echo "Key: $key, Value: $value"
done < $CONFIG_FILE

