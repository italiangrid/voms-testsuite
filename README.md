# VOMS clients testsuite

A [Robot-powered][robot-framework] VOMS clients testsuite.

## Requirements

-   A VOMS installation configured according to the [test fixture](./fixture/populate-vo.sh)
-   The [IGI test-ca](https://github.com/italiangrid/test-ca) package installed & trusted

## Running the testsuite

Use the `italiangrid/voms-testsuite-centos7` docker image to run the testsuite.

### Testsuite parameters

| Parameter name | Description                        | Default value                                                                                                    |
| -------------- | ---------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| `vo1`          | Name of the VO under test          | test.vo                                                                                                          |
| `vo2`          | Name of the second VO under test   | test.vo.2                                                                                                        |
| `vo1_host`     | Name of the host for the first VO  | vgrid02.cnaf.infn.it                                                                                             |
| `vo2_host`     | Name of the host for the second VO | vgrid02.cnaf.infn.it                                                                                             |
| `vo1_issuer`   | VOMS subject DN for the first VO   | /DC=org/DC=terena/DC=tcs/C=IT/L=Frascati/O=Istituto Nazionale di Fisica Nucleare/OU=CNAF/CN=vgrid02.cnaf.infn.it |
| `vo2_issuer`   | VOMS subject DN for the second VO  | DC=org/DC=terena/DC=tcs/C=IT/L=Frascati/O=Istituto Nazionale di Fisica Nucleare/OU=CNAF/CN=vgrid02.cnaf.infn.it  |

For other parameters, see the [variables file](./lib/variables.robot).
