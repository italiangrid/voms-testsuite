*** Settings ***
Resource   lib/vomslib.robot
Resource   lib/variables.robot
Documentation  Tests for voms-proxy-init command line options

*** Test cases ***

See if voms-proxy-init --quiet works
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  ${output}   Create proxy   --voms ${vo1} -q 
  Should Be Equal  ${output}  ${EMPTY}
  [Teardown]  Stop using certificate

See if voms-proxy-init --limited (gt2) works
  [Setup]  Use certificate  test0
  Create Proxy  --limited
  ${output}   Run   voms-proxy-info3 ${options}
  Should Contain  ${output}  limited proxy
  [Teardown]  Stop using certificate

See if voms-proxy-init --bits works
  [Tags]  legacy
  [Setup]  Use certificate  test0
  Create Proxy  --bits 2048
  ${output}  Get proxy openssl
  Should Contain  ${output}  Public-Key: (2048 bit)
  [Teardown]  Stop using certificate

See if voms-proxy-init --conf works
  [Tags]  legacy
  [Setup]  Use certificate  test0
  ${tmpFile}   Run  mktemp /tmp/voms-testXXX
  Execute and Check Success   echo "--version" > ${tmpFile}
  ${output}  Create Proxy  --conf ${tmpFile}
  Should Contain  ${output}   voms-proxy-init
  Execute and Check Success   rm ${tmpFile}

See if voms-proxy-init --path_length works
  [Tags]  legacy
  [Setup]  Use certificate  test0
  ${option}  Set Variable If  ${client_version} == 2  --path-length  --path_length
  Create Proxy  --rfc ${option} 1
  ${output}  Get proxy openssl
  Should Contain  ${output}  Path Length Constraint: 01
  [Teardown]  Stop using certificate

See if voms-proxy-init --failonwarn works
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  ${rc}  Run and Return RC  echo ${privateKeyPassword} | voms-proxy-init -pwstdin -voms ${vo1} --failonwarn --valid 100:00
  Should Be Equal As Integers  ${rc}  1
  [Teardown]  Stop using certificate

See if voms-proxy-init --ignorewarn works
  [Tags]  legacy
  [Setup]  Use certificate  test0
  ${output}  Create Proxy  --ignorewarn --hours 100
  Should Not Contain  ${output}  Warning
  [Teardown]  Stop using certificate

See if voms-proxy-init --order works
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  Create proxy   -voms ${vo1} -order /${vo1}/G1
  ${output}  Get proxy info  -fqan
  ${expected}=  Set Variable If  ${vo1_legacy_fqan_enabled} == True  /${vo1}/G1/Role=NULL/Capability=NULL\n/${vo1}/Role=NULL/Capability=NULL\n/${vo1}/G2/Role=NULL/Capability=NULL\n/${vo1}/G2/G3/Role=NULL/Capability=NULL  /${vo1}/G1\n/${vo1}\n/${vo1}/G2\n/${vo1}/G2/G3  
  Should Be Equal As Strings  ${output}  ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-init --order works with multiple arguments
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  Create proxy   -voms ${vo1} -order /${vo1}/G2/G3 -order /${vo1}/G2 
  ${output}  Get proxy info  -fqan
  ${expected}=  Set Variable If  ${vo1_legacy_fqan_enabled} == True  /${vo1}/G2/G3/Role=NULL/Capability=NULL\n/${vo1}/G2/Role=NULL/Capability=NULL   /${vo1}/G2/G3\n/${vo1}/G2
  Should Start With  ${output}  ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-init manages unrecognized options
  [Tags]  legacy
  [Setup]  Use certificate  test0
  ${output}  Create Proxy Failure  --dummyoption
  Should Contain  ${output}  nrecognized option
  [Teardown]  Stop using certificate

See if voms-proxy-init --version works
  [Tags]  legacy
  [Setup]  Use certificate  test0
  ${output}  Create Proxy  --version
  Should Contain  ${output}   voms-proxy-init
  [Teardown]  Stop using certificate

See if voms-proxy-init -help works
  [Tags]  legacy
  ${output}  Create Proxy  -help
  ${expected}  Set Variable If  ${client_version} == 2  voms-proxy-init*Options*  usage: voms-proxy-init [options*
  Should Match  ${output}   ${expected}

See if voms-proxy-init --proxyver 10 fails correctly
  [Tags]  legacy
  ${output}  Create Proxy failure  -proxyver 10

See if -pwstdin works with voms-proxy-init
  [Tags]  legacy
  [Setup]  Use certificate  test0
  Create proxy
  [Teardown]  Stop using certificate

Check that -cert option is considered when -noregen option is specified
  [Tags]   remote  regression  VOMS-461  legacy
  [Setup]  Use certificate  test0
  ${tempCert}  Run  mktemp /tmp/voms_testXXX
  Create proxy  --out ${tempCert} 
  Create proxy  --noregen --cert ${tempCert}
  ${output}  Get proxy info
  Should Contain   ${output}   issuer    : /C=IT/O=IGI/CN=test0/CN=proxy
  Should Contain   ${output}   subject   : /C=IT/O=IGI/CN=test0/CN=proxy/CN=proxy  
  [Teardown]   Stop using certificate
