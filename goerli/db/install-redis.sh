#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install redis-goerli -n redis-goerli --create-namespace -f redis-values.yml bitnami/redis-cluster

# kubectl get secret redis-goerli-redis-cluster-crt -n redis-goerli -o yaml | grep -v '^\s*namespace:\s' | kubectl apply -n goerli -f -

# ------------------------------------------------------------
# Output:
# ------------------------------------------------------------

# To get your password run:
#     export PASSWORD=$(kubectl get secret --namespace "redis-goerli" redis -o jsonpath="{.data.password}" | base64 -d)

# You have deployed a Redis&reg; Cluster accessible only from within you Kubernetes Cluster.INFO: The Job to create the cluster will be created.To connect to your Redis&reg; cluster:

# 1. Run a Redis&reg; pod that you can use as a client:
# kubectl run --namespace redis-goerli redis-goerli-redis-cluster-client --rm --tty -i --restart='Never' \
#  --env REDIS_PASSWORD=$REDIS_PASSWORD --image docker.io/bitnami/redis-cluster:7.0.10-debian-11-r2 -- bash

# 2. Connect using the Redis&reg; CLI:
# redis-cli -c -h redis-goerli-redis-cluster -a $REDIS_PASSWORD
