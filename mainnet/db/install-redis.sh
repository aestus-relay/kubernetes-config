#!/bin/bash

# Prior to running this, deploy a secret with a password field

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install redis -n redis --create-namespace -f redis-values.yml bitnami/redis-cluster

# ------------------------------------------------------------
# Output:
# ------------------------------------------------------------

# To get your password run:
#     export PASSWORD=$(kubectl get secret --namespace "redis" redis -o jsonpath="{.data.password}" | base64 -d)

# You have deployed a Redis&reg; Cluster accessible only from within you Kubernetes Cluster.INFO: The Job to create the cluster will be created.To connect to your Redis&reg; cluster:

# 1. Run a Redis&reg; pod that you can use as a client:
# kubectl run --namespace redis redis-redis-cluster-client --rm --tty -i --restart='Never' \
#  --env REDIS_PASSWORD=$REDIS_PASSWORD \
# --image docker.io/bitnami/redis-cluster:7.2.2-debian-11-r0 -- bash

# 2. Connect using the Redis&reg; CLI:
# redis-cli -c -h redis-redis-cluster -a $REDIS_PASSWORD
