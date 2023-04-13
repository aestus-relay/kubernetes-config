#!/bin/bash
set -x

# Get main branch of kube-prometheus
git clone https://github.com/prometheus-operator/kube-prometheus
cd kube-prometheus
git checkout main

# Install according to instructions in readme
kubectl apply --server-side -f manifests/setup
kubectl wait \
	--for condition=Established \
	--all CustomResourceDefinition \
	--namespace=monitoring
kubectl apply -f manifests/

# Patch to keep metrics-server working
kubectl patch networkpolicy prometheus-k8s -n monitoring --patch-file prometheus-k8s-patch.yml

#https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/additional-scrape-config.md
kubectl create secret generic additional-scrape-configs --from-file=prometheus-additional.yaml --dry-run=client -oyaml > additional-scrape-configs.yaml
kubectl apply -f additional-scrape-configs.yaml -n monitoring
kubectl apply -f manifests/prometheus-prometheus.yaml

