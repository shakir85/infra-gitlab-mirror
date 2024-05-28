#!/bin/bash

# Script to generate k8s dashboard token


kubectl proxy > /dev/null 2>&1 &
echo "kubectl proxy is ready on default port 8001"
kubectl -n kubernetes-dashboard get secret $(kubectl -n kubernetes-dashboard get sa/admin-user -o jsonpath="{.secrets[0].name}") -o go-template="{{.data.token | base64decode}}"

echo ""

