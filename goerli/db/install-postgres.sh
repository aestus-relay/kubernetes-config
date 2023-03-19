#!/bin/bash

helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update

helm install postgres-goerli -n pg-goerli --create-namespace -f values.yml bitnami/postgresql-ha

# ------------------------------------------------------------
# Output:
# ------------------------------------------------------------

# PostgreSQL can be accessed through Pgpool via port 5432 on the following DNS name from within your cluster:
#
# postgres-goerli-postgresql-ha-pgpool.pg-goerli.svc.cluster.local
#
# Pgpool acts as a load balancer for PostgreSQL and forward read/write connections to the primary node while read-only connections are forwarded to standby nodes.
#
#To get the password for "relay" run:
#    export POSTGRES_PASSWORD=$(kubectl get secret --namespace pg-goerli postgresql -o jsonpath="{.data.password}" | base64 -d)
#
# To get the password for "repmgr" run:
#    export REPMGR_PASSWORD=$(kubectl get secret --namespace pg-goerli postgresql -o jsonpath="{.data.repmgr-password}" | base64 -d)
#
# To connect to your database run the following command:
#    kubectl run postgres-goerli-postgresql-ha-client --rm --tty -i --restart='Never' --namespace pg-goerli --image docker.io/bitnami/postgresql-repmgr:15.2.0-debian-11-r12 --env="PGPASSWORD=$POSTGRES_PASSWORD"  \
#    --command -- psql -h postgres-goerli-postgresql-ha-pgpool -p 5432 -U relay -d relay-db
#
# To connect to your database from outside the cluster execute the following commands:
#    kubectl port-forward --namespace pg-goerli svc/postgres-goerli-postgresql-ha-pgpool 5432:5432 &
#    psql -h 127.0.0.1 -p 5432 -U relay -d relay-db

# ------------------------------------------------------------
# Migration Notes:
# ------------------------------------------------------------

# Use above `kubectl run` command but with /bin/bash instead of psql to get a shell in the container
# Create a pgpass file in the container with both databases and passwords
# Format: hostname:port:database:username:password
# e.g.: relay-db-goerli-do-user-12853860-0.b.db.ondigitalocean.com:25060:relay-db:relay:$PASSWORD

# Run a pg_dump piped to a psql command to migrate the data:
# pg_dump -C -h relay-db-goerli-do-user-12853860-0.b.db.ondigitalocean.com -p 25060 -U relay -d relay-db | psql -h postgres-goerli-postgresql-ha-pgpool.pg-goerli.svc.cluster.local -p 5432 -U relay -d relay-db

# This will take some time.
