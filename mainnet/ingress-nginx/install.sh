#!/bin/bash
# Source: https://kubernetes.github.io/ingress-nginx/deploy

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.7.0/deploy/static/provider/do/deploy.yaml

kubectl patch deployment ingress-nginx-controller -n ingress-nginx --type json --patch-file nginx-ingress-deployment-opadd.json
kubectl patch deployment ingress-nginx-controller -n ingress-nginx --type json --patch-file nginx-ingress-deployment-opreplace.json
kubectl patch service ingress-nginx-controller -n ingress-nginx --type strategic --patch-file nginx-ingress-service-eth-port-proxies-patch.yml
kubectl patch service ingress-nginx-controller -n ingress-nginx --type strategic --patch-file nginx-ingress-service-annotations-patch.yml
kubectl patch configmap ingress-nginx-controller -n ingress-nginx --type strategic --patch-file nginx-ingress-configmap-config.yml
