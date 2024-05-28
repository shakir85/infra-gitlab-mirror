#!/bin/bash

# A naive script that sends a GET request to multiple applications running on 127.0.0.1
# that listen on different ports. If the the request != 200, the script will exit 1. 
#
# The port numbers are stored in a local file, line-delemited. The ports file path
# is relative to this script.
# 
# The objective of this script is to test that apps are up and running
# especially after a mass docker container updates.
#

echo "Start testing..."

declare -a arr
IFS=$'\n' read -d '' -r -a arr < ./ports

for PORT in "${arr[@]}"
do
   STATUS_CODE=$(curl -sI http://127.0.0.1:"$PORT" | head -n 1 | cut -d$' ' -f2)
   if [ "$STATUS_CODE" != "200" ]; then
     echo "Port $PORT returned $STATUS_CODE , aborting..."
     exit 1
   else
     echo "Service is active."
   fi
done
