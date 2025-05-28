# VOMS clients testsuite

A [Robot-powered][robot-framework] VOMS clients testsuite.

## Requirements

-   A VOMS installation configured according with the [test fixture](./compose/assets/scripts/setup-and-start-voms.sh)
-   `voms_vo_0` and `voms_vo_1` databases populated as per [db dump](./compose/assets/db)
-   The [IGI test-ca](https://github.com/italiangrid/test-ca) package installed & trusted

## Running the testsuite

Use the `italiangrid/voms-testsuite` docker image to run the testsuite.

### Testsuite parameters

| Parameter name | Description                        | Default value                                                                                                    |
| -------------- | ---------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `vo1`          | Name of the VO under test          | test.vo                                                                                                          |
| `vo2`          | Name of the second VO under test   | test.vo.2                                                                                                        |
| `vo1_host`     | Name of the host for the first VO  | vgrid02.cnaf.infn.it                                                                                             |
| `vo2_host`     | Name of the host for the second VO | vgrid02.cnaf.infn.it                                                                                             |
| `vo1_issuer`   | VOMS subject DN for the first VO   | /DC=org/DC=terena/DC=tcs/C=IT/L=Frascati/O=Istituto Nazionale di Fisica Nucleare/OU=CNAF/CN=vgrid02.cnaf.infn.it |
| `vo2_issuer`   | VOMS subject DN for the second VO  | DC=org/DC=terena/DC=tcs/C=IT/L=Frascati/O=Istituto Nazionale di Fisica Nucleare/OU=CNAF/CN=vgrid02.cnaf.infn.it  |
| `vo1_legacy_fqan_enabled`     | Encode FQANs released by first VO as per legacy VOMS | True                                                                                             |
| `vo2_legacy_fqan_enabled`     | Encode FQANs released by second VO as per legacy VOMS | True                                                                                             |
| `vo1_is_voms_aa`     | First VO is served by a voms-aa server | False                                                                                             |
| `vo2_is_voms_aa`     | Second VO is served by a voms-aa server | False                                                                                             |

For other parameters, see the [variables file](./lib/variables.robot).


### Using docker compose

A [docker compose](./compose/docker-compose.ci.yml) file collecting all the necessary services can be used to run the testsuite.

#### Tests using local VOMS server

Start the trustanchor job with

```
$ cd compose
$ docker compose --file docker-compose.ci.yml up --build trust
[+] Building 38.3s (7/9)                                                               docker-container:practical_dewdney
 => [trust internal] load metadata for docker.io/library/almalinux:9                                                 0.9s
 => [trust auth] library/almalinux:pull token for registry-1.docker.io                                               0.0s
 => [trust internal] load .dockerignore                                                                              0.0s
 => => transferring context: 2B                                                                                      0.0s
 => [trust internal] load build context                                                                              0.0s
 => => transferring context: 4.41kB                                                                                  0.0s
 => CACHED [trust 1/4] FROM docker.io/library/almalinux:9@sha256:787a2698464bf554d02aeeba4e0b022384b21d1419511bfb03  0.0s
 => => resolve docker.io/library/almalinux:9@sha256:787a2698464bf554d02aeeba4e0b022384b21d1419511bfb033a2d440d9f230  0.0s
 => [trust 2/4] COPY ./x509 /                                                                                        0.1s
 => [trust 3/4] RUN dnf install -y epel-release &&       dnf -y update &&       dnf -y install git voms-clients-cp  37.2s
...
trust-1 exited with code 0
```

Start the db, VOMS and testsuite containers

```
$ docker compose --file docker-compose.ci.yml up --detach db voms testsuite
```

Populate the VOMS DB with a dbdump for testing and start VOMS

```
$ docker compose --file docker-compose.ci.yml exec -T --workdir /scripts db bash /scripts/populate-db.sh
$ docker compose --file docker-compose.ci.yml exec -T --workdir /scripts voms bash /scripts/setup-and-start-voms.sh
```

Run the testsuite with

```
$ docker compose --file docker-compose.ci.yml exec -T testsuite bash /scripts/ci-run-testsuite.sh
```

#### Tests using local VOMS-AA microservice

Start all services with

```
$ cd compose
$ docker compose --file docker-compose.ci.yml up --build -d
[+] Running 9/9
 ⠿ Network voms-testsuite_default           Created     0.1s
 ⠿ Volume "voms-testsuite_cabundle"         Created     0.0s
 ⠿ Volume "voms-testsuite_trustanchors"     Created     0.0s
 ⠿ Container voms-testsuite-trust-1         Started     1.6s
 ⠿ Container db                             Started     1.4s
 ⠿ Container voms-testsuite-testsuite-1     Started     1.6s
 ⠿ Container voms-testsuite-voms-1          Started     1.4s
 ⠿ Container voms-testsuite-vomsaa-1        Started     2.2s
 ⠿ Container voms-testsuite-ngx-1           Started     44.7s
```

Populate the VOMS-AA db with a dbdump for testing (it is a shared db with the VOMS one, that will be populated as well)

```
$ docker compose --file docker-compose.ci.yml exec -T --workdir /scripts db bash /scripts/populate-db.sh
```

Run the testsuite. Some variables will be overridden using the `ROBOT_OPTIONS` environment variable

```
$ export ROBOT_OPTIONS="--variable vo1:vo.2 --variable vo1_host:voms-aa.test.example --variable vo1_issuer:/C=IT/O=IGI/CN=voms-aa.test.example --variable vo2:vo.1 --variable vo2_host:voms.test.example --variable vo2_issuer:/C=IT/O=IGI/CN=voms.test.example"
$ docker compose --file docker-compose.ci.yml exec -T -e ROBOT_OPTIONS="${ROBOT_OPTIONS}" testsuite bash /scripts/ci-run-testsuite.sh
```


[robot-framework]: https://robotframework.org/
