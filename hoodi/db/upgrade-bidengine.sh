#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm upgrade redis -n bidengine -f bidengine-values.yml bitnami/redis
