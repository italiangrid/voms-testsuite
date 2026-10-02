#!/bin/bash

if [ -z "${VOMS_SRC}" ]; then
  echo "Set the VOMS_SRC environment variable to point to the VOMS sources. Exiting..."
  exit 1
fi

VOMS_HOST=${VOMS_HOST:-voms.test.example}
DEV_USER=${DEV_USER:-test}
VOMS_USER=${VOMS_USER:-voms}
SCRIPTS="/scripts"

docker compose -f compose/docker-compose.dev.yml pull

docker compose -f compose/docker-compose.dev.yml build --no-cache trust
docker compose -f compose/docker-compose.dev.yml up -d

docker compose -f compose/docker-compose.dev.yml exec -T db bash ${SCRIPTS}/populate-db.sh

uid=$(id -u)
gid=$(id -g)

docker compose -f compose/docker-compose.dev.yml exec -u root -T testsuite groupmod -g ${gid} ${DEV_USER}
docker compose -f compose/docker-compose.dev.yml exec -u root -T testsuite usermod -u ${uid} ${DEV_USER}
docker compose -f compose/docker-compose.dev.yml exec -u root -T testsuite ${SCRIPTS}/setup-testsuite.sh

docker compose -f compose/docker-compose.dev.yml exec -T voms groupmod -g ${gid} ${VOMS_USER}
docker compose -f compose/docker-compose.dev.yml exec -T voms usermod -u ${uid} ${VOMS_USER}
docker compose -f compose/docker-compose.dev.yml exec -T voms bash ${SCRIPTS}/setup-voms.sh
docker compose -f compose/docker-compose.dev.yml exec -u voms -T voms bash ${SCRIPTS}/start-voms.sh
