#!/bin/bash

if [ -z "${VOMS_SRC}" ]; then
  echo "Set the VOMS_SRC environment variable to point to the VOMS sources. Exiting..."
  exit 1
fi

VOMS_HOST=${VOMS_HOST:-voms.test.example}
DEV_USER=${DEV_USER:-test}
SCRIPTS="/voms-testsuite/compose/assets/scripts"

docker compose -f compose/docker-compose.dev.yml build --no-cache trust
docker compose -f compose/docker-compose.dev.yml up -d

docker compose -f compose/docker-compose.dev.yml exec -T db bash /scripts/populate-db.sh

uid=$(id -u)
gid=$(id -g)
docker compose -f compose/docker-compose.dev.yml exec -T testsuite sudo groupmod -g ${gid} ${DEV_USER}
docker compose -f compose/docker-compose.dev.yml exec -T testsuite sudo usermod -u ${uid} ${DEV_USER}
docker compose -f compose/docker-compose.dev.yml exec -T voms groupmod -g ${gid} ${DEV_USER}
docker compose -f compose/docker-compose.dev.yml exec -T voms usermod -u ${uid} ${DEV_USER}

docker compose -f compose/docker-compose.dev.yml exec -u root -e VOMS_HOST=${VOMS_HOST} -T testsuite bash -c "sudo ${SCRIPTS}/setup-testsuite.sh"

docker compose -f compose/docker-compose.dev.yml exec -T voms bash ${SCRIPTS}/setup-voms.sh
docker compose -f compose/docker-compose.dev.yml exec -T voms bash ${SCRIPTS}/start-voms.sh
