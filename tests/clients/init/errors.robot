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
  [Tags]  remote  legacy
  [Setup]   Use certificate   test3
  ${output}   Create proxy failure   -voms ${vo1}:/${vo1}/G1/Role=R1
  Should Contain   ${output}   User unknown to this VO
  [Teardown]   Stop using certificate

Request for non-existing role should fail
  [Tags]  remote  legacy
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -voms ${vo1}:/${vo1}/G1/Role=Berlusconi
  IF  ${client_version} == 2
    Should Contain   ${output}   None of the contacted servers for ${vo1} were capable\nof returning a valid AC for the user.
  ELSE
    Should Contain   ${output}   Remote VOMS server contacted succesfully.
    Should Contain   ${output}   User's request for VOMS attributes could not be fulfilled.
  END
  [Teardown]   Stop using certificate

Invalid key size request should fail
  [Tags]  legacy
  [Setup]   Use certificate   test0
  ${expected}  Set Variable If  ${client_version} == 2  Error: number of bits in key must be one of  Unsupported key size:
  ${output}   Create proxy failure   -bits 5000
  Should Contain   ${output}   ${expected} 
  ${output}   Create proxy failure   -bits -128
  Should Contain   ${output}   ${expected} 
  # 0 bits is a valid request and takes the length from the certificate
  IF  ${client_version} != 2
    ${output}   Create proxy failure   -bits 0
    Should Contain   ${output}   ${expected}
  END
  ${output}   Create proxy failure   -bits 473289ybf
  ${expected}  Set Variable If  ${client_version} == 2  Error: number of bits in key must be one of  Invalid input for key size parameter. Please provide a valid key size value.
  Should Contain   ${output}   ${expected}
  [Teardown]   Stop using certificate

Invalid validity request should fail
  [Tags]  legacy
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -valid 5000
  ${expected}  Set Variable If  ${client_version} == 2  -valid argument must be in the format: h:m  Illegal format for lifetime property.
  Should Contain   ${output}   ${expected}
  ${output}   Create proxy failure   -valid -5000:0
  ${expected}  Set Variable If  ${client_version} == 2  specified hours must be positive  Number of hours must be a positive integer.
  Should Contain   ${output}   ${expected}
  ${output}   Create proxy failure   -valid 50:-10
  ${expected}  Set Variable If  ${client_version} == 2  specified minutes must be in the range 0-59  Number of minutes must be a positive integer.
  Should Contain   ${output}   ${expected}
  ${output}   Create proxy failure   -valid 12:121
  ${expected}  Set Variable If  ${client_version} == 2  specified minutes must be in the range 0-59  Number of minutes must be in the range 0-59.
  Should Contain   ${output}   ${expected}
  [Teardown]   Stop using certificate

Invalid vomslife request should fail
  [Tags]  remote legacy
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -vomslife 5000
  ${expected}  Set Variable If  ${client_version} == 2  -vomslife argument must be in the format: h:m  Illegal format for lifetime property.
  Should Contain   ${output}  ${expected} 
  ${output}   Create proxy failure   -vomslife -12:12
  ${expected}  Set Variable If  ${client_version} == 2  specified hours must be positive  Number of hours must be a positive integer.
  Should Contain   ${output}   ${expected}
  ${output}   Create proxy failure   -vomslife 12:-12
  ${expected}  Set Variable If  ${client_version} == 2  specified minutes must be in the range 0-59  Number of minutes must be a positive integer.
  Should Contain   ${output}   ${expected}
  ${output}   Create proxy failure   -vomslife 12:121
  ${expected}  Set Variable If  ${client_version} == 2  specified minutes must be in the range 0-59  Number of minutes must be in the range 0-59.
  Should Contain   ${output}   ${expected}
  [Teardown]   Stop using certificate

Request for unknown VO should produce meaningful error message
  [Tags]  remote  legacy
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -voms paolabarale
  ${expected}  Set Variable If  ${client_version} == 2  VOMS Server for paolabarale not known!  VOMS server for VO paolabarale is not known! Check your vomses configuration.
  Should Contain   ${output}   ${expected}
  [Teardown]   Stop using certificate

voms-proxy-init correctly fails on mixed proxy chains
  [Setup]   Setup mixed proxy chain
  ${output}   Create proxy failure   --noregen
  Should Contain   ${output}   Cannot generate a proxy certificate starting from a mixed type proxy chain.
  [Teardown]   Stop using certificate

See if voms-proxy-init fails correctly when cert and key do not match
  [Tags]  legacy
  [Setup]  Use mixed credentials  test0   test1
  ${output}   Create proxy failure
  ${expected}  Set Variable If  ${client_version} == 2  user key and certificate don't match  Provided private key is not matching the certificate
  Should Contain   ${output}   ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-init fails correctly when the key has incorrect permissions
  [Tags]  legacy
  [Setup]  Use certificate   test0
  Execute and Check Success   chmod 777 %{HOME}/.globus/userkey.pem
  ${output}   Create Proxy Failure
  ${expected}  Set Variable If  ${client_version} == 2  ERROR: Couldn't find valid credentials to generate a proxy.  Wrong file permissions on file %{HOME}/.globus/userkey.pem. Required permissions are: 400
  Should Contain   ${output}  ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-init fails correctly when the key is empty
  [Tags]  legacy
  [Setup]  Use certificate   test0
  Execute and Check Success   rm -f %{HOME}/.globus/userkey.pem
  Execute and Check Success   touch %{HOME}/.globus/userkey.pem
  ${output}   Create Proxy Failure
  ${expected}  Set Variable If  ${client_version} == 2  ERROR: Couldn't find valid credentials to generate a proxy.  No credentials found!
  Should Contain   ${output}  ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-init fails correctly when the key is corrupted
  [Tags]  legacy
  [Setup]  Use certificate   test0
  ${tmpKey}   Run  mktemp /tmp/key-XXX
  Execute and Check Success  cat %{HOME}/.globus/userkey.pem|tr [a-z] [A-Z] > ${tmpKey}
  Execute and Check Success   chmod 400 ${tmpKey}
  ${output}   Create Proxy Failure   --cert %{HOME}/.globus/usercert.pem --key ${tmpKey}
  ${expected}  Set Variable If  ${client_version} == 2  *wrong tag*  *Can not load the PEM private key*
  Should Match   ${output}   ${expected}
  [Teardown]  Stop using certificate

Check the error message if a file cannot be written
  # why cannot it be overwritten like the cpp client does?
  [Setup]  Use certificate   test0
  ${tmpFile}   Run  mktemp /tmp/voms-testXXX
  Execute and Check Success  chmod 0000 ${tmpFile}
  ${output}  Create Proxy Failure  -out ${tmpFile}
  Should Contain  ${output}  Permission denied
  [Teardown]  Stop using certificate

A user gets the right message when trying to create a proxy without a certificate
  [Tags]  legacy
  [Setup]   Stop using certificate
  ${output}  Create proxy failure  -pwstdin 
  ${expected}  Set Variable If  ${client_version} == 2  Unable to find user certificate or key:  No credentials found!
  Should Contain  ${output}  ${expected}

A user gets the right message when trying to create a proxy providing the wrong passphrase
  [Tags]  legacy
  [Setup]  Use certificate   test0
  ${output}  Execute and Check Failure   echo "CAMAGHE" | voms-proxy-init -pwstdin
  ${expected}  Set Variable If  ${client_version} == 2  wrong pass  Error decrypting private key: the password is incorrect or the PEM data is corrupted.
  Should Contain  ${output}  ${expected}
  [Teardown]  Stop using certificate

A user cannot get a proxy from a VO she does not belong to
  [Tags]  remote  legacy
  [Setup]   Use certificate   test5
  Check voms-proxy-init failure  User unknown to this VO
  [Teardown]   Stop using certificate

See if voms-proxy-init fails with a fake target
  [Tags]  remote  legacy  issue-723
  [Setup]  Use certificate  test0       
  ${output}  Create proxy failure  -voms ${vo1} -target fake.cnaf.infn.it
  ${expected}  Set Variable If  ${client_version} == 2  Cannot find match among allowed hosts.  AC target check failed
  Should Contain   ${output}  ${expected}
  [Teardown]  Stop using certificate

See if missing certificate implies an error
  [Tags]  remote  legacy
  Create proxy failure  -voms ${vo1}

See if voms-proxy-init --out fails correctly when given a wrong location
  [Tags]  legacy
  [Setup]  Use certificate  test0
  File Should Not Exist  /unlikely/path
  ${output}  Create proxy failure  --out /unlikely/path 
  ${expected}  Set Variable If  ${client_version} == 2  ERROR: Cannot write proxy to: /unlikely/path  Error creating proxy certificate: /unlikely/path
  Should Contain  ${output}  ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-init -pwstdin fails correctly when no password is provided
  [Tags]  legacy
  [Setup]  Use certificate  test0
  IF  ${client_version} == 2
    ${output}  Execute and Check Failure   echo "" | voms-proxy-init -pwstdin
    Should Contain Any  ${output}  bad password read  empty password
    ${output}  Execute and Check Failure   echo "" | voms-proxy-init -pwstdin -debug
    Should Contain Any  ${output}  bad password read  empty password
  ELSE
    ${output}  Execute and Check Failure  echo "" | voms-proxy-init --pwstdin
    Should contain  ${output}  No credentials found!
    ${output}  Execute and Check Failure  echo "" | voms-proxy-init --pwstdin --debug
    Should contain  ${output}  Credentials couldn't be loaded
    Should contain  ${output}  Error decrypting private key: the password is incorrect or the PEM data is corrupted
    Should contain  ${output}  No credentials found!
  END
  [Teardown]  Stop using certificate

See if suspended users can get a proxy
  [Tags]  legacy
  [Setup]  Use certificate  test2
  ${output}  Create proxy failure  -voms ${vo1}
  ${expected}  Set Variable If  ${vo1_is_voms_aa}  is not active.  User is currently suspended!
  Should Contain   ${output}  ${expected}
  [Teardown]  Stop using certificate