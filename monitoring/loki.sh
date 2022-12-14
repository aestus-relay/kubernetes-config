#!/bin/bash
set -x

helm repo add loki https://grafana.github.io/loki/charts
helm repo update
helm upgrade --install loki loki/loki-stack --namespace monitoring --set loki.persistence.enabled=true,loki.persistence.storageClassName=do-block-storage,loki.persistence.size=5Gi
