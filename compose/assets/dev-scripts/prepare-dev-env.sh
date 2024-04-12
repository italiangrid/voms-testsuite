#!/bin/bash

if [ -z "${VOMS_SRC}" ]; then
    echo "Set the VOMS_SRC environment variable to point to the VOMS sources. Exiting..."
    exit 1
fi

docker compose -f compose/docker-compose.dev.yml up -d

uid=$(id -u)
gid=$(id -g)

for service in testsuite voms-7-stable voms-7-beta voms-9-beta; do
  docker compose -f compose/docker-compose.dev.yml exec $service sudo groupmod -g ${gid} test
  docker compose -f compose/docker-compose.dev.yml exec $service sudo usermod -u ${uid} test
done
