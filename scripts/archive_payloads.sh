#!/bin/bash
set -x

if (( $# != 2 )); then
    echo "Usage: namespace time_to_keep"
    echo "Backs up in bunches of 10,000 indices"
    echo "time_to_keep must be in a form recorgnized by date -d\"-\$time_to_keep\""
    echo "You must specify POSTGRES_USER, POSTGRES_PASSWORD, POSTGRES_URI, POSTGRES_PORT, and POSTGRES_DB as environment variables"
    exit
fi
namespace="${1}"

# kubectl exec --stdin --tty cleanup -n "${namespace}" -- /bin/sh

# Create a pod for executing the backup
kubectl apply -f cleanup.yml -n "${namespace}"
kubectl wait --for=condition=ready -n "${namespace}" pod cleanup
kubectl exec cleanup -n "${namespace}" -- sh -c 'mkdir -p /backup/payloads /backup/payloads'

# Query DB to figure out how much to export
step="10000"
date_limit=$(date -d"-${2}")
export PGPASSWORD=${POSTGRES_PASSWORD}
min_payload=$(psql -t -U ${POSTGRES_USER} -h ${POSTGRES_URI} -p ${POSTGRES_PORT} -d ${POSTGRES_DB} --set=sslmode=require -c "SELECT id from dev_execution_payload order by id asc limit 1")
max_payload=$(psql -t -U ${POSTGRES_USER} -h ${POSTGRES_URI} -p ${POSTGRES_PORT} -d ${POSTGRES_DB} --set=sslmode=require -c "SELECT id from dev_execution_payload where inserted_at<'${date_limit}' order by id desc limit 1")
min_id=$(awk -v n="${min_payload}" -v d="${step}" "BEGIN{print int(n/d)*d}")
max_id=$(awk -v n="${max_payload}" -v d="${step}" "BEGIN{print int(n/d)*d}")

# Check for special case
if [ -z "${max_payload}" ] || [ "${min_id}" -eq "${max_id}" ]; then
    echo "No payloads are older than ${2}, exiting"
    kubectl delete pod cleanup -n "${namespace}"
    exit
fi

echo "Archiving ${namespace} payloads older than ${2} with ids ${min_id}-${max_id}..."
read -p "press enter"

for (( i = $min_id; i < $max_id; i += $step )); do
    id_start="${i}"
    id_end="$(( i + step ))"
    fn1="${i}.csv"
    fn2="${i}.json"

    echo "Exporting ${id_start} to ${id_end}..."
    kubectl exec cleanup -n "${namespace}" -- env id_start=${id_start} id_end=${id_end} fn1=${fn1} fn2=${fn2} sh -c './mev-boost-relay tool archive-execution-payloads --db "postgres://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_URI}:${POSTGRES_PORT}/relay-db" --id-from "${id_start}" --id-to "${id_end}" --out "/backup/payloads/${fn1}" --out "/backup/payloads/${fn2}" --delete'

    echo "Compressing ${id_start}..."
    kubectl exec cleanup -n "${namespace}" -- env fn1=${fn1} fn2=${fn2} sh -c 'gzip /backup/payloads/${fn1} /backup/payloads/${fn2}'
done

# Delete the pod
kubectl delete pod cleanup -n "${namespace}"
