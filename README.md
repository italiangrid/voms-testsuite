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

For other parameters, see the [variables file](./lib/variables.robot).


### Using docker compose

A [docker compose](./compose/docker-compose.ci.yml) file collecting all the necessary services can be used to run the testsuite.

#### Tests using local VOMS server

Start the trustanchor job with

```
$ cd compose
$ docker compose --file docker-compose.ci.yml up trust
trust_1      | + FETCH_CRL_TIMEOUT_SECS=5
trust_1      | + [[ -z 1 ]]
trust_1      | + fetch-crl --verbose -T 5
trust_1      | VERBOSE(1) Initializing trust anchor AC-GRID-FR-Personnels
trust_1      | VERBOSE(1) Initializing trust anchor AC-GRID-FR-Robots
...
voms-testsuite_trust_1 exited with code 0
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

Run the testsuite. Some variables will be overridden using the `ROBOT_OPTIONS` environment variable

```
$ export ROBOT_OPTIONS="--variable vo1:vo.0 --variable vo1_host:voms.test.example --variable vo1_issuer:/C=IT/O=IGI/CN=*.test.example --variable vo2:vo.1 --variable vo2_host:voms.test.example --variable vo2_issuer:/C=IT/O=IGI/CN=*.test.example"
$ docker compose --file docker-compose.ci.yml exec -T -e ROBOT_OPTIONS="${ROBOT_OPTIONS}" testsuite bash /scripts/ci-run-testsuite.sh
```

#### Tests using local VOMS-AA microservice

Start all services with

```
$ cd compose
$ docker compose --file docker-compose.ci.yml up -d
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
$ export ROBOT_OPTIONS="--variable vo1:indigo-dc --variable vo1_host:voms-aa.test.example --variable vo1_issuer:/C=IT/O=IGI/CN=*.test.example --variable --variable vo2:vo.1 --variable vo2_host:voms.test.example --variable vo2_issuer:/C=IT/O=IGI/CN=*.test.example"
$ docker compose --file docker-compose.ci.yml exec -T -e ROBOT_OPTIONS="${ROBOT_OPTIONS}" testsuite bash /scripts/ci-run-testsuite.sh
```

[robot-framework]: https://robotframework.org/
