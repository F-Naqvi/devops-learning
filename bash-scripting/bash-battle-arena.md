#Bash Battle Arena Solutions & Notes

##Level 1

**Challenge:** Create directory "Arens" and list contents

**Solution:**
```#!/bin/bash

mkdir Arena
cd Arena
touch warrior.txt mage.txt archer.txt

ls
```


##Level 2

**Challenge:** Create script that outputs 1-10

**Solution:**
```#!/bin/bash

for (( i=1; i<=10; i++)); do
    echo "$i"
done
```


##Level 3

**Challenge:** Write script to check if file exists

**Solution:**
```#!/bin/bash

if [ -f "Arena/hero.txt" ]; then
    echo "File exists!"
else
    echo "File does not exist!"
fi
```


##Level 4

**Challenge:** Write script that copies files from one directory to another

**Solution:**
```#!/bin/bash

source_dir="/Users/faseehnaqvi/devops/Arena"
dest_dir="/Users/faseehnaqvi/devops/Backup"

for file in "$source_dir"/*.txt
do
    if [ -f "$file" ]; then
        cp "$file" "$dest_dir"
    fi
done
```


##Level 5

**Challenge:** Write script that:
-Creates a directory named "battlefield"
-Creates files inside battlefield
-Check if specific file inside directory exists
-Move to another directory "Archive"
List contents of both directories

**Solution:**
```#!/bin/bash

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
```
