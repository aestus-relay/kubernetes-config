# Aestus Relay Kubernetes Configuration

This repository contains Kubernetes manifests for the Aestus mev-boost relay. Secrets are excluded.

## Structure

Manifests are written in YAML and roughly organized by application:

* dash: Kubernetes Dashboard
* eth-goerli: Ethereum execution and consensus client pair
* relay: Relay databases and API servers
* registry: Docker registry

# Third-Party Manifests

* [Kubernetes Dashboard v2.6.1](https://github.com/kubernetes/dashboard/releases/tag/v2.6.1)
* [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)
