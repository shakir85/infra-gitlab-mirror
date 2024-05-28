#!/bin/bash 

# Delete stuck K8s namespace
# Usage: ./del-stuck-namespace.sh <namespace>
# Must be admin + can run kube proxy

NAMESPACE=$1

kubectl proxy > /dev/null 2>&1 &

kubectl get namespace $NAMESPACE -o json | jq '.spec = {"finalizers":[]}' > temp.json

curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$NAMESPACE/finalize

rm temp.json
