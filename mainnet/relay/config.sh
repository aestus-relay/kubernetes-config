#!/bin/bash
# DigitalOcean-specific configuration for redis servers, idle timeout must be longer on server than on client (both 300s by default)
# DO_AUTH_TOKEN: A DigitalOcean authentication token for API access
# REDIS_DB_ID: DigitalOcean's ID for the redis server, can be found under `doctl db list`

curl -X PATCH -H "Content-Type: application/json"  -H "Authorization: Bearer ${DO_AUTH_TOKEN}" -d '{"config":{"redis_timeout": 3600}}' "https://api.digitalocean.com/v2/databases/${REDIS_DB_ID}/config"
