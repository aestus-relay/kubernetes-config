#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade redis-goerli -n redis-goerli -f redis-values.yml bitnami/redis-cluster
