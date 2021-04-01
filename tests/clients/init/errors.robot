*** Settings ***
Resource   lib/vomslib.robot
Resource   lib/variables.robot
Documentation  Tests for error conditions for voms-proxy-init

*** Keywords ***

Setup mixed proxy chain
  Use certificate   test0
  Create proxy   
  Create proxy   -rfc --skip_chain_integrity_checks -noregen
  Create proxy   -noregen -proxyver 3 --skip_chain_integrity_checks

*** Test Cases ***

Non member request for role should fail
  [Tags]  remote
  [Setup]   Use certificate   test3
  ${output}   Create proxy failure   -voms ${vo1}:/${vo1}/G1/Role=R1
  Should Contain   ${output}   User unknown to this VO
  [Teardown]   Stop using certificate

Request for non-existing role should fail
  [Tags]  remote
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -voms ${vo1}:/${vo1}/G1/Role=Berlusconi
  Should Contain   ${output}   Remote VOMS server contacted succesfully.
  Should Contain   ${output}   User's request for VOMS attributes could not be fulfilled.
  [Teardown]   Stop using certificate

Invalid key size request should fail
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -bits 5000
  Should Contain   ${output}   Unsupported key size: 
  ${output}   Create proxy failure   -bits -128
  Should Contain   ${output}   Unsupported key size: 
  ${output}   Create proxy failure   -bits 0
  Should Contain   ${output}   Unsupported key size: 
  ${output}   Create proxy failure   -bits 473289ybf
  Should Contain   ${output}   Invalid input for key size parameter. Please provide a valid key size value.
  [Teardown]   Stop using certificate

Invalid validity request should fail
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -valid 5000
  Should Contain   ${output}   Illegal format for lifetime property.
  ${output}   Create proxy failure   -valid -5000:0
  Should Contain   ${output}   Number of hours must be a positive integer.
  ${output}   Create proxy failure   -valid 50:-10
  Should Contain   ${output}   Number of minutes must be a positive integer.
  ${output}   Create proxy failure   -valid 12:121
  Should Contain   ${output}   Number of minutes must be in the range 0-59.
  [Teardown]   Stop using certificate

Invalid vomslife request should fail
  [Tags]  remote
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -vomslife 5000
  Should Contain   ${output}  Illegal format for lifetime property. 
  ${output}   Create proxy failure   -vomslife -12:12
  Should Contain   ${output}   Number of hours must be a positive integer.
  ${output}   Create proxy failure   -vomslife 12:-12
  Should Contain   ${output}   Number of minutes must be a positive integer.
  ${output}   Create proxy failure   -vomslife 12:121
  Should Contain   ${output}   Number of minutes must be in the range 0-59.
  [Teardown]   Stop using certificate

Request for unknown VO should produce meaningful error message
  [Tags]  remote
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -voms paolabarale
  Should Contain   ${output}   VOMS server for VO paolabarale is not known! Check your vomses configuration.
  [Teardown]   Stop using certificate

voms-proxy-init correctly fails on mixed proxy chains
  [Setup]   Setup mixed proxy chain
  ${output}   Create proxy failure   --noregen
  Should Contain   ${output}   Cannot generate a proxy certificate starting from a mixed type proxy chain.
  [Teardown]   Stop using certificate

See if voms-proxy-init fails correctly when cert and key do not match
  [Setup]  Use mixed credentials  test0   test1
  ${output}   Create proxy failure
  Should Contain   ${output}   Provided private key is not matching the certificate
  [Teardown]  Stop using certificate

See if voms-proxy-init fails correctly when the key has incorrect permissions
  [Setup]  Use certificate   test0
  Execute and Check Success   chmod 777 %{HOME}/.globus/userkey.pem
  ${output}   Create Proxy Failure
  Should Contain   ${output}  Wrong file permissions on file %{HOME}/.globus/userkey.pem. Required permissions are: 400 
  [Teardown]  Stop using certificate

See if voms-proxy-init fails correctly when the key is empty
  [Setup]  Use certificate   test0
  Execute and Check Success   rm -f %{HOME}/.globus/userkey.pem
  Execute and Check Success   touch %{HOME}/.globus/userkey.pem
  ${output}   Create Proxy Failure
  Should Contain   ${output}   No credentials found! 
  [Teardown]  Stop using certificate

See if voms-proxy-init fails correctly when the key is corrupted
  [Setup]  Use certificate   test0
  ${tmpKey}   Run  mktemp /tmp/key-XXX
  Execute and Check Success  cat %{HOME}/.globus/userkey.pem|tr [a-z] [A-Z] > ${tmpKey}
  Execute and Check Success   chmod 400 ${tmpKey}
  ${output}   Create Proxy Failure   --cert %{HOME}/.globus/usercert.pem --key ${tmpKey}
  Should Contain   ${output}   Can not load the PEM private key
  [Teardown]  Stop using certificate

Check the error message if a file cannot be written
  [Setup]  Use certificate   test0
  ${tmpFile}   Run  mktemp /tmp/voms-testXXX
  Execute and Check Success  chmod 0000 ${tmpFile}
  ${output}  Create Proxy Failure  -out ${tmpFile}
  Should Contain  ${output}  Permission denied
  [Teardown]  Stop using certificate

A user gets the right message when trying to create a proxy without a certificate
  [Setup]   Stop using certificate
  ${output}  Create proxy failure  -pwstdin 
  Should Contain  ${output}  No credentials found!

A user gets the right message when trying to create a proxy providing the wrong passphrase
  [Setup]  Use certificate   test0
  ${output}  Execute and Check Failure   echo "CAMAGHE" | voms-proxy-init -pwstdin
  Should Contain  ${output}  Error decrypting private key: the password is incorrect or the PEM data is corrupted.
  [Teardown]  Stop using certificate

A user cannot get a proxy from a VO she does not belong to
  [Tags]  remote
  [Setup]   Use certificate   test5
  Check voms-proxy-init failure  User unknown to this VO
  [Teardown]   Stop using certificate

See if voms-proxy-init fails with a fake target
  [Tags]  remote
  [Setup]  Use certificate  test0       
  ${output}  Create proxy failure  -voms ${vo1} -target fake.cnaf.infn.it
  Should Contain   ${output}  AC target check failed
  [Teardown]  Stop using certificate

See if missing certificate implies an error
  [Tags]  remote
  Create proxy failure  -voms ${vo1}

See if voms-proxy-init --out fails correctly when given a wrong location
  [Setup]  Use certificate  test0
  File Should Not Exist  /unlikely/path
  ${output}  Create proxy failure  --out /unlikely/path 
  Should Contain  ${output}  Error creating proxy certificate: /unlikely/path
  [Teardown]  Stop using certificate

See if voms-proxy-init -pwstdin fails correctly when no password is provided
  [Setup]  Use certificate  test0
  ${output}  Execute and Check Failure  echo "" | voms-proxy-init --pwstdin
  Should contain  ${output}  No credentials found!
  ${output}  Execute and Check Failure  echo "" | voms-proxy-init --pwstdin --debug
  Should contain  ${output}  Credentials couldn't be loaded
  Should contain  ${output}  Error decrypting private key: the password is incorrect or the PEM data is corrupted
  Should contain  ${output}  No credentials found!
  [Teardown]  Stop using certificate
