#!/bin/bash

# Expected to run in an image containing postgresql client tools of the same version as the server
# A volume for backups should be mounted at /backup

if (( $# != 2 )); then
    echo "Usage: $0 prefix time_to_keep"
    echo "time_to_keep must be in a form acceptable to find -mtime, e.g. 7 for 7 days (the + is automatically added)"
    echo "You must specify the following environment variables: POSTGRES_HOST, POSTGRES_PORT, POSTGRES_USER, POSTGRES_PASSWORD, and POSTGRES_DB"
    exit 1
fi

set -x

# Create new backup
export PGPASSWORD=${POSTGRES_PASSWORD}
mkdir -p /backup/pgdb
pg_dump -C -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USER -d $POSTGRES_DB --exclude-table-data=dev_execution_payload > /backup/pgdb/"${1}_$(date +%Y%m%d_%H%M%S).sql"

# Delete old backups
find /backup/pgdb -name "${1}"* -mtime +"${2}" -delete
