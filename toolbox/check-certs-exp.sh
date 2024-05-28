#!/bin/bash

# TODO: 
#   - Use regex to process other extensions like .crt
#   - Parametrize certs path

for pem in /etc/ssl/certs/*.pem; do
   printf '%s: %s\n' \
      "$(date --date="$(openssl x509 -enddate -noout -in "$pem"|cut -d= -f 2)" --iso-8601)" \
      "$pem"
done | sort
