*** Settings ***
Resource   lib/vomslib.robot
Resource   lib/variables.robot
Documentation  Tests for voms-proxy-init interaction with the environment: pki materials location, vomses, vomsdir

*** Keywords ***

Setup invalid vomsdir 
  ${tmpVomsDir}   Run   mktemp -d /tmp/vomsdir-XXXX
  Create Directory   ${tmpVomsDir}/${vo2}
  Create File   ${tmpVomsDir}/${vo2}/${vo2_host}.lsc  ${vo2_issuer}\n/C=IT/O=INFN/CN=INFN CA
  Set Environment Variable   __VOMS_CUSTOM_VOMSDIR__   ${tmpVomsDir}

Setup for X509_VOMS_DIR test
  Use certificate   test0
  ${x509VomsDir}  Run   mktemp -d /tmp/vomsdir-XXXX
  Set Environment Variable  X509_VOMS_DIR  ${x509VomsDir}

Teardown for X509_VOMS_DIR test
  Remove Environment Variable  X509_VOMS_DIR
  Stop using certificate

Setup for vomses test   [Arguments]   ${vomsesDir}
  Use certificate   test0
  Execute and Check Success  mkdir -p ${vomsesDir}
  Execute and Check Success   cp -a /etc/vomses ${vomsesDir}

Teardown for vomses test   [Arguments]   ${vomsesDir}
  Execute and Check Success  rm -rf ${vomsesDir}
  Stop using certificate

Setup for X509_CERT_DIR test   [Arguments]   ${x509CertDir}
  Use certificate   test0
  Set Environment Variable  X509_CERT_DIR  ${x509CertDir}

Teardown for X509_CERT_DIR test
  Remove Environment Variable  X509_CERT_DIR
  Stop using certificate

Setup for empty certdir test
  ${tmpCertDir}   Run   mktemp -d /tmp/certdir-XXXX
  Run  mkdir ${tmpCertDir}
  Set Environment Variable   __VOMS__CUSTOM__CERTDIR__   ${tmpCertDir}
  Use certificate  test0
  [Return]   ${tmpCertDir}

Teardown for empty certdir test
  Remove Environment Variable   __VOMS__CUSTOM__CERTDIR__
  Stop using certificate

*** Test Cases ***

voms-proxy-init --vomsdir fails with non-existent vomsdir 
  [Tags]  remote
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -voms ${vo1} -vomsdir /unlikely/path
  Should Contain   ${output}   Invalid vomsdir location: '/unlikely/path' (file not found) 
  [Teardown]   Stop using certificate

voms-proxy-init --vomsdir overrides standard vomsdir
  [Tags]  remote
  [Setup]   Use certificate   test0
  Setup invalid vomsdir 
  ${tmpVomsDir}   Get Environment Variable   __VOMS_CUSTOM_VOMSDIR__
  ${output}   Create proxy failure   -voms ${vo1} -vomsdir ${tmpVomsDir}
  Should Contain   ${output}   LSC validation failed: LSC file matching VOMS attributes not found in store.
  Remove Environment Variable   __VOMS_CUSTOM_VOMSDIR__
  [Teardown]   Stop using certificate

voms-proxy-init --certdir fails nicely with non-existent directory
  [Tags]  remote  legacy
  [Setup]   Use certificate   test0
  ${output}   Create proxy failure   -voms ${vo1} -certdir /unlikely/path
  ${expected}  Set Variable If  ${client_version} == 2  unable to access trusted certificates in:x509_cert_dir=/unlikely/path  Invalid trust anchors location: '/unlikely/path' (file not found)
  Should Contain   ${output}   ${expected}
  [Teardown]   Stop using certificate

See if voms-proxy-init reads ~/.voms/vomses
  [Tags]  remote  legacy
  [Setup]  Setup for vomses test  %{HOME}/.voms
  ${output}  Create Proxy  -debug -voms ${vo1}
  ${expected}  Set Variable If  ${client_version} == 2  Using configuration file %{HOME}/.voms/vomses  from %{HOME}/.voms
  Should Contain  ${output}  ${expected}
  [Teardown]  Teardown for vomses test  %{HOME}/.voms

See if voms-proxy-init reads ~/.glite/vomses
  [Tags]  remote  legacy
  [Setup]  Setup for vomses test  %{HOME}/.glite
  ${output}  Create Proxy  -debug -voms ${vo1}
  ${expected}  Set Variable If  ${client_version} == 2  Using configuration file %{HOME}/.glite/vomses  from %{HOME}/.glite
  Should Contain  ${output}  ${expected}
  [Teardown]  Teardown for vomses test  %{HOME}/.glite

See if AC validation fails when LSC file does not exist
  [Tags]  remote  legacy
  [Setup]  Setup for X509_VOMS_DIR test
  ${output}  Create proxy failure   -voms ${vo1}
  ${expected}=  Set Variable If  ${client_version} == 2  Error: verification failed.\nCannot verify AC signature!  VOMS AC validation for VO ${vo1} failed
  Should Contain  ${output}  ${expected}
  [Teardown]  Teardown for X509_VOMS_DIR test

See if voms-proxy-init warns when X509_CERT_DIR does not point to a directory
  [Tags]   dev  legacy
  [Setup]  Setup for X509_CERT_DIR test   /unlikely/path
  ${output}  Create Proxy Failure  --verify
  ${expected}=  Set Variable If  ${client_version} == 2  unable to access trusted certificates in:x509_cert_dir=  Invalid trust anchors location
  Should Contain  ${output}  ${expected}
  [Teardown]  Teardown for X509_CERT_DIR test

See if voms-proxy-init writes an error message when the trust anchors location does not contain the ca
  [Tags]  legacy
  [Setup]  Setup for X509_CERT_DIR test   /tmp
  ${output}  Create Proxy Failure  --verify
  ${expected}=  Set Variable If  ${client_version} == 2  certificate validation error: unable to get issuer certificate  No trusted CA certificate was found for the certificate chain
  Should Contain  ${output}  ${expected}
  [Teardown]  Teardown for X509_CERT_DIR test

See if voms-proxy-info honors X509_USER_PROXY
  [Tags]  regression  legacy
  [Documentation]  Regression test for https://issues.infn.it/jira/browse/VOMS-296. Command voms-proxy-info ignores variable X509_USER_PROXY.
  [Setup]  Use certificate  test0
  Create voms proxy
  ${proxyFile}  Get proxy path
  ${tmpFile}  Run  mktemp /tmp/voms-testXXX
  Execute and Check Success  mv ${proxyFile} ${tmpFile} 
  Set environment variable  X509_USER_PROXY  ${tmpfile}
  ${output}  Get proxy info
  Should Not Contain  ${output}  Proxy not found
  Remove environment variable  X509_USER_PROXY
  [Teardown]  Stop using certificate

See if voms-proxy-init honors X509_USER_PROXY
  [Tags]  voms-proxy-init  legacy
  [Documentation]  Command voms-proxy-init must save file to the path pointed to by the env variable X509_USER_PROXY when this is set.
  [Setup]  Use certificate  test0
  ${tmpFile}  Run  mktemp /tmp/voms-testXXX
  Set environment variable  X509_USER_PROXY  ${tmpfile}
  Create voms proxy
  File Should Exist  ${tmpfile} 
  Remove environment variable  X509_USER_PROXY
  [Teardown]  Stop using certificate

See if voms-proxy-init --vomses fails correctly when given a wrong location
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  Should Not Exist  /unlikely/path
  ${output}  Create proxy failure  --voms ${vo1} --vomses /unlikely/path
  ${expected}=  Set Variable If  ${client_version} == 2  Cannot find file or dir: /unlikely/path  No valid VOMSES information found locally while looking in: [/unlikely/path]
  Should contain  ${output}   ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-init --certdir works
  [Tags]  legacy
  [Setup]  Setup for empty certdir test
  ${tmpCertDir}   Get Environment Variable   __VOMS__CUSTOM__CERTDIR__ 
  ${output}  Create Proxy Failure  --certdir ${tmpCertDir} --verify
  ${expected}=  Set Variable If  ${client_version} == 2  Error: Certificate verification failed.\ncertificate validation error: unable to get issuer certificate  Certificate validation error: Trusted issuer of this certificate was not established
  Should Contain  ${output}  ${expected}
  [Teardown]  Teardown for empty certdir test

Check that proxy is correctly understood by dCache SRM clients
   [Tags]   regression   remote   VOMS-424  legacy
   [Setup]   Use certificate   test0
   Create Proxy
   ${version}   Run   voms-proxy-init --version
   ${output}   Run   srmls ${srmEndpoint}
   Should Not Contain   ${output}   [JGLOBUS-12] No private key loaded
   [Teardown]   Stop using certificate
