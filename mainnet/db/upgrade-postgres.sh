#!/bin/bash

helm repo update

export POSTGRES_PASSWORD=$(kubectl get secret --namespace pg-mainnet postgresql -o jsonpath="{.data.password}" | base64 -d)
export REPMGR_PASSWORD=$(kubectl get secret --namespace pg-mainnet postgresql -o jsonpath="{.data.repmgr-password}" | base64 -d)
export ADMIN_PASSWORD=$(kubectl get secret --namespace "pg-mainnet" postgres-mainnet-postgresql-ha-pgpool -o jsonpath="{.data.admin-password}" | base64 -d)

helm upgrade postgres-mainnet -n pg-mainnet -f postgres-values.yml bitnami/postgresql-ha \
     --set pgpool.adminPassword="$ADMIN_PASSWORD" \
     --set postgresql.password="$POSTGRES_PASSWORD" \
     --set postgresql.repmgrPassword="$REPMGR_PASSWORD"
