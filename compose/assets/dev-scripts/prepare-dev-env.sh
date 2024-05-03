#!/bin/bash

if [ -z "${VOMS_SRC}" ]; then
  echo "Set the VOMS_SRC environment variable to point to the VOMS sources. Exiting..."
  exit 1
fi

VOMS_HOST=${VOMS_HOST:-voms.test.example}
DEV_USER=${DEV_USER:-test}
SCRIPTS="/voms-testsuite/compose/assets/scripts"

docker compose -f compose/docker-compose.dev.yml up -d

docker compose -f compose/docker-compose.dev.yml exec -T db bash /scripts/populate-db.sh

uid=$(id -u)
gid=$(id -g)
for service in testsuite-7-stable testsuite-7-beta testsuite-9-beta voms-7-stable voms-7-beta voms-9-beta; do
  docker compose -f compose/docker-compose.dev.yml exec -T $service sudo groupmod -g ${gid} ${DEV_USER}
  docker compose -f compose/docker-compose.dev.yml exec -T $service sudo usermod -u ${uid} ${DEV_USER}
  docker compose -f compose/docker-compose.dev.yml exec -T $service bash -c "sudo ${SCRIPTS}/provide-igi-test-ca.sh"
done

for service in testsuite-7-stable testsuite-7-beta testsuite-9-beta; do
  docker compose -f compose/docker-compose.dev.yml exec -u root -e VOMS_HOST=${VOMS_HOST} -T $service bash -c "sudo ${SCRIPTS}/setup-testsuite.sh"
done

for service in voms-7-stable voms-7-beta voms-9-beta; do
  docker compose -f compose/docker-compose.dev.yml exec -T $service bash ${SCRIPTS}/setup-voms.sh
  docker compose -f compose/docker-compose.dev.yml exec -T $service bash ${SCRIPTS}/start-voms.sh
done
