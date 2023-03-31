#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade memcached-goerli -n mcd-goerli -f memcached-values.yml bitnami/memcached
