# Aestus Relay Kubernetes Configuration

This repository contains Kubernetes manifests for the Aestus mev-boost relay. Secrets are excluded.

## Structure

Manifests are written in YAML and roughly organized:

* cert-manager: SSL certificate manager
* goerli: Goerli testnet EL/CL clients, mev-boost relay, and ingress
* homepage: A landing page for the relay project as a whole
* mainnet: Ethereum mainnet EL/CL clients, mev-boost relay, and ingress

# Third-Party Manifests

* [NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/deploy/)
