#!/bin/bash

# Prior to running this, deploy a secret with a password field

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install redis -n bidengine --create-namespace -f bidengine-values.yml bitnami/redis

# CLI Access:
# export REDIS_PASSWORD=$(kubectl get secret --namespace bidengine redis -o jsonpath="{.data.password}" | base64 -d)
# kkubectl run --namespace bidengine redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.2.5-debian-12-r0 --command -- sleep infinity
# REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-master
# REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-replicas

# kubectl port-forward --namespace bidengine svc/redis-master 6379:6379 &
# REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379
