#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install memcached -n mcd --create-namespace -f memcached-values.yml bitnami/memcached

# Instances are accessible on these FQDNs:
# memcached-0.memcached.mcd.svc.cluster.local:11211
# memcached-1.memcached.mcd.svc.cluster.local:11211
# etc.

# To access the Memcached instance from outside the cluster execute:
# kubectl run telnet --rm --image=mikesplain/telnet --stdin --tty -n mainnet --command -- /bin/sh
# telnet memcached-0.memcached.mcd.svc.cluster.local 11211

# Note:
# Without using mcrouter, data is not replicated between nodes
# Applications must connect to *all* nodes to get all data
# In case of a crash, data is inaccesible until the node is restarted
# However, this still provides redundancy in that we're less likely to lost memcached altogether
