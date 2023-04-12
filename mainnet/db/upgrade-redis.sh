#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade redis-mainnet -n redis-mainnet -f redis-values.yml bitnami/redis-cluster
