#!/bin/bash

# travers applications sub-directoreis
# in each directory, run:
#   docker-compose down --rmi all
#   docker-compuse up -d --build

for directory in ${HOME}/apps/*; do
        if [ -d "$directory" ]; then
                echo "Going to directory: $directory ..."
                cd $directory
                pwd
                /usr/local/bin/docker-compose down --rmi all
                /usr/local/bin/docker-compose up --build -d
        fi
done
