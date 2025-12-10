# VOMS clients testsuite

A [Robot-powered][robot-framework] VOMS clients testsuite.

## Requirements

- A VOMS installation configured according with the [test fixture](./compose/assets/scripts/setup-and-start-voms.sh)
- The `voms_vo_0`, `voms_vo_1` and `voms_vo_2` databases populated as per [DB dump](./compose/assets/db). The first two are used by the VOMS server, the latter by VOMS-AA

## Testsuite parameters

| Parameter name            | Description                                       | Default value                    |
| ------------------------- | ------------------------------------------------- | -------------------------------- |
| `vo1`                     | Name of the first VO under test                   | vo.0                             |
| `vo2`                     | Name of the second VO under test                  | vo.1                             |
| `vo1_host`                | Name of the host for `vo1`                        | voms.test.example                |
| `vo2_host`                | Name of the host for `vo2`                        | voms.test.example                |
| `vo1_issuer`              | VOMS subject DN for `vo1`                         | /C=IT/O=IGI/CN=voms.test.example |
| `vo2_issuer`              | VOMS subject DN for `vo2`                         | /C=IT/O=IGI/CN=voms.test.example |
| `vo1_legacy_fqan_enabled` | Apply legacy encoding to FQANs issued by `vo1`    | True                             |
| `vo2_legacy_fqan_enabled` | Apply legacy encoding to FQANs issued by `vo2`    | True                             |
| `vo1_is_voms_aa`          | `vo1` is served by VOMS-AA                        | False                            |
| `vo2_is_voms_aa`          | `vo2` is served by VOMS-AA                        | False                            |
| `client_version`          | `2` for the C++ clients, `3` for the Java clients | 3                                |

For other parameters, see the [variables file](./lib/variables.robot).

## Testsuite docker image

The `italiangrid/voms-testsuite` docker image contains all the necessary dependencies to run the testsuite.

## Using docker compose

A [docker compose](./compose/docker-compose.ci.yml) file, including all the necessary services, can be used to run the testsuite. It is the same compose file used for the Continuous Integration.

Start all services after building the trust store:

```shell
cd compose
docker compose --file docker-compose.ci.yml build --no-cache trust
docker compose --file docker-compose.ci.yml up -d
```

Populate the database with a database dump for testing. The database is a shared between the VOMS server and VOMS-AA.

```shell
docker compose --file docker-compose.ci.yml exec -T --workdir /scripts db bash /scripts/populate-db.sh
```

To start the VOMS server:

```shell
docker compose --file docker-compose.ci.yml exec -T --workdir /scripts voms bash /scripts/setup-and-start-voms.sh
```

VOMS-AA instead starts automatically.

To run the testsuite against VOMS server:

```shell
docker compose --file docker-compose.ci.yml exec -T testsuite bash /scripts/ci-run-testsuite.sh
```

To run the testsuite against VOMS-AA, first set some of the above variables, e.g. setting the `ROBOT_OPTIONS` environment variable

```shell
export ROBOT_OPTIONS="--variable vo1:vo.2 --variable vo1_host:voms-aa.test.example --variable vo1_issuer:/C=IT/O=IGI/CN=voms-aa.test.example --variable vo2:vo.1 --variable vo2_host:voms.test.example --variable vo2_issuer:/C=IT/O=IGI/CN=voms.test.example --variable vo1_is_voms_aa:True"
docker compose --file docker-compose.ci.yml exec -T -e ROBOT_OPTIONS="${ROBOT_OPTIONS}" testsuite bash /scripts/ci-run-testsuite.sh
```

By default, the Java clients are used. To switch to the C++ clients:

```shell
docker compose --file docker-compose.ci.yml exec -T -u root testsuite bash -c "update-alternatives --set voms-proxy-init /usr/bin/voms-proxy-init2; update-alternatives --set voms-proxy-info /usr/bin/voms-proxy-info2; update-alternatives --set voms-proxy-destroy /usr/bin/voms-proxy-destroy2"
```

then run again the testsuite, setting the `robot` variable `client_version` to the value 2, either in the `ROBOT_OPTIONS` environment variable or passing it to the `ci-run-testsuite.sh` script.

After each run of the testsuite, collect the reports from the container, possibly resetting them:

```shell
docker compose --file docker-compose.ci.yml cp testsuite:/tmp/reports ./reports
docker compose --file docker-compose.ci.yml exec -T testsuite rm -rf /tmp/reports
```

[robot-framework]: https://robotframework.org/
