#!/bin/bash

# Prior to running this, deploy a secret with a password field

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install redis -n redis --create-namespace -f redis-values.yml bitnami/redis

# CLI Access:
# export REDIS_PASSWORD=$(kubectl get secret --namespace redis redis -o jsonpath="{.data.redis-password}" | base64 -d)
# kubectl run -n redis redis-client --rm --tty -i --restart='Never' --env REDIS_PASSWORD=$PASSWORD --image docker.io/bitnami/redis:7.2.4-debian-12-r9 -- bash
# REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-master
# REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-replicas

# kubectl port-forward --namespace redis svc/redis-master 6379:6379 &
# REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379
