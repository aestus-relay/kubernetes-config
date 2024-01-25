#!/bin/bash

# Prior to running this, deploy a secret with a password field

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install redis -n redis --create-namespace -f redis-values.yml bitnami/redis-cluster

# kubectl get secret redis-goerli-redis-cluster-crt -n redis-goerli -o yaml | grep -v '^\s*namespace:\s' | kubectl apply -n goerli -f -
