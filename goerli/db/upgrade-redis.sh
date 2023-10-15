#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade redis -n redis -f redis-values.yml bitnami/redis-cluster
