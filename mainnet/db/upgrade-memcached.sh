#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade memcached-mainnet -n mcd-mainnet -f memcached-values.yml bitnami/memcached
