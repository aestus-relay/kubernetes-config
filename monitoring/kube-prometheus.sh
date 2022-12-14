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
