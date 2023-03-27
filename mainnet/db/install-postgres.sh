#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install postgres-mainnet -n pg-mainnet --create-namespace -f values.yml bitnami/postgresql-ha

# ------------------------------------------------------------
# Output:
# ------------------------------------------------------------

# PostgreSQL can be accessed through Pgpool via port 5432 on the following DNS name from within your cluster:
#      postgres-mainnet-postgresql-ha-pgpool.pg-mainnet.svc.cluster.local

# Pgpool acts as a load balancer for PostgreSQL and forward read/write connections to the primary node while read-only connections are forwarded to standby nodes.

# To get the password for "relay" run:

#     export POSTGRES_PASSWORD=$(kubectl get secret --namespace pg-mainnet postgresql -o jsonpath="{.data.password}" | base64 -d)

# To get the password for "repmgr" run:

#     export REPMGR_PASSWORD=$(kubectl get secret --namespace pg-mainnet postgresql -o jsonpath="{.data.repmgr-password}" | base64 -d)

# To connect to your database run the following command:

#     kubectl run postgres-mainnet-postgresql-ha-client --rm --tty -i --restart='Never' --namespace pg-mainnet --image docker.io/bitnami/postgresql-repmgr:15.2.0-debian-11-r13 --env="PGPASSWORD=$POSTGRES_PASSWORD"  \
#         --command -- psql -h postgres-mainnet-postgresql-ha-pgpool -p 5432 -U relay -d relay-db

# To connect to your database from outside the cluster execute the following commands:

#     kubectl port-forward --namespace pg-mainnet svc/postgres-mainnet-postgresql-ha-pgpool 5432:5432 &
#     psql -h 127.0.0.1 -p 5432 -U relay -d relay-db

# ------------------------------------------------------------
# Migration Notes:
# ------------------------------------------------------------

# Use above `kubectl run` command but with /bin/bash instead of psql to get a shell in the container
# May need to use a more vanilla postgres image
# Create a pgpass file in the container with both databases and passwords
# Format: hostname:port:database:username:password
# e.g.: relay-db-do-user-12853860-0.b.db.ondigitalocean.com:25060:relay-db:relay:$PASSWORD
# export PGPASSFILE=/tmp/pgpass or wherever you want to put it

# Run a pg_dump piped to a psql command to migrate the data:
# pg_dump -C -h relay-db-do-user-12853860-0.b.db.ondigitalocean.com -p 25060 -U relay -d relay-db --exclude-table-data=dev_execution_payload | psql -h postgres-mainnet-postgresql-ha-pgpool.pg-mainnet.svc.cluster.local -p 5432 -U relay -d relay-db

# This will take some time.
