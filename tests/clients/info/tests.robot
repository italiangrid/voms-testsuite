*** Settings ***
Resource   lib/vomslib.robot
Resource   lib/variables.robot
Documentation  Generic tests for voms-proxy-info

*** Test Cases ***

See if voms-proxy-info --version returns after displaying the version
  [Tags]  legacy
  ${output}  Get proxy info  --version
  ${expected}   Set Variable If  ${client_version} == 2  voms-proxy-info\nVersion: \.\*\nCompiled:  voms-proxy-info v. \\w
  Should Match Regexp  ${output}  ${expected}

Check if voms-proxy-info suceeds on a plain proxy
  [Setup]  Use certificate   test0
  [Tags]  legacy
  Create Proxy
  Get Proxy Info
  [Teardown]  Stop using certificate

A user gets the right message when trying to access an unavailable proxy
  [Tags]  legacy
  [Setup]   Stop using certificate
  ${output}   Execute and Check Failure   voms-proxy-info
  ${expected}   Set Variable If  ${client_version} == 2  Couldn't find a valid proxy  Proxy not found
  Should Contain  ${output}  ${expected}

A user can see the info of a plain proxy
  [Setup]  Use certificate  test0
  [Tags]  legacy
  Create plain Proxy
  ${output}  Get proxy info
  Should Contain  ${output}  subject
  [Teardown]  Stop using certificate

See if a voms proxy has the right attributes
  [Setup]  Use certificate  test0
  [Tags]   remote   rfc  legacy
  Create voms proxy
  ${output}=   Get proxy info  -all
  Log   ${output}
  Should Match Regexp  ${output}  subject\\s+:\\s+/C=IT/O=IGI/CN=test0/CN=[0-9]+
  Should Match Regexp  ${output}  issuer\\s+:\\s+/C=IT/O=IGI/CN=test0
  Should Match Regexp  ${output}  identity\\s+:\\s+/C=IT/O=IGI/CN=test0
  ${expected}=  Set Variable If  ${client_version} == 2  RFC compliant proxy  RFC3820 compliant impersonation proxy
  Should Match Regexp  ${output}  type\\s+:\\s+${expected}
  ${expected}=  Set Variable If  ${client_version} == 2  1024  2048
  Should Match Regexp  ${output}  strength\\s+:\\s+${expected}
  Should Match Regexp  ${output}  path\\s+:\\s+/tmp/x509up_u\\d+
  Should Match Regexp  ${output}  timeleft\\s+:\\s+\\d+:\\d+:\\d+
  ${expected}=  Set Variable If  ${client_version} == 2  Digital Signature, Key Encipherment  Digital Signature, Non Repudiation, Key Encipherment
  Should Match Regexp  ${output}  key usage\\s+:\\s+${expected}
  Should Match Regexp  ${output}  === VO ${vo1} extension information ===
  Should Match Regexp  ${output}  VO\\s+:\\s+${vo1}
  Should Match Regexp  ${output}  subject\\s+:\\s+/C=IT/O=IGI/CN=test0/
  ${vo1_issuer_escaped} =  Regexp Escape  ${vo1_issuer}  
  Should Match Regexp  ${output}  issuer\\s+:\\s+${vo1_issuer_escaped}
  Should Match Regexp  ${output}  attribute\\s+:\\s+/${vo1}/Role=NULL/Capability=NULL
  Should Match Regexp  ${output}  attribute\\s+:\\s+/${vo1}/G1/Role=NULL/Capability=NULL
  Should Match Regexp  ${output}  timeleft\\s+:\\s+\\d+:\\d+:\\d+
  Should Match Regexp  ${output}  uri\\s+:\\s+${vo1_host}:\\d+
  [Teardown]  Stop using certificate

Check if the option '-exists -valid' works
  [Setup]  Use certificate  test0
  [Tags]  legacy
  Create proxy   -valid 10:00
  ${output}  Execute and Check Success   voms-proxy-info -exists -valid 09:00;echo $?
  Should Contain  ${output}  0
  [Teardown]  Stop using certificate

Check if the option '-exists -valid' fails when it should
  [Setup]  Use certificate  test0
  [Tags]  legacy
  Create proxy   -valid 10:00
  ${output}   Execute and Check Success   voms-proxy-info -exists -valid 13:00;echo $?
  Should Contain  ${output}  1
  [Teardown]  Stop using certificate

See if voms-proxy-info '--exists --bits' works
  [Setup]  Use certificate  test0
  Create plain Proxy
  ${output}   Get proxy info   -exists -bits 2048;echo $?
  Should Contain  ${output}  0
  [Teardown]  Stop using certificate

See if voms-proxy-info -vo works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output}   Get proxy info  -vo
  Should Contain  ${output}  ${vo1}
  [Teardown]  Stop using certificate

See if voms-proxy-info -acexists works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output}   Get proxy info  -acexists ${vo1};echo $?
  Should Contain  ${output}  0
  [Teardown]  Stop using certificate

See if voms-proxy-info -acissuer works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output}   Get proxy info  -acissuer
  Should Match  ${output}  ${vo1_issuer} 
  [Teardown]  Stop using certificate

See if voms-proxy-info -acsubject works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output}   Get proxy info  -acsubject
  Should Match Regexp  ${output}  /C=IT/O=IGI/CN=test0
  [Teardown]  Stop using certificate

See if voms-proxy-info -actimeleft works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output}   Get proxy info  -actimeleft
  Should Match Regexp  ${output}  ^[0-9]{1,6}$
  [Teardown]  Stop using certificate

See if voms-proxy-info -fqan works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output}   Get proxy info  -fqan
  Log  ${output}
  ${expected}   Set Variable  /${vo1}/Role=NULL/Capability=NULL\n/${vo1}/G1/Role=NULL/Capability=NULL\n/${vo1}/G2/Role=NULL/Capability=NULL\n/${vo1}/G2/G3/Role=NULL/Capability=NULL
  Log  ${expected}
  Should Be Equal As Strings  ${output}  ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-info -path works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output}   Get proxy info  -path
  Should Match Regexp  ${output}  /tmp/x509up_u\\d+
  [Teardown]  Stop using certificate


See if voms-proxy-info -strength works
  [Setup]  Use certificate  test0
  [Tags]   remote
  Create voms proxy
  ${output} =  Get proxy info  -strength
  Should Match Regexp  ${output}  2048  
  [Teardown]  Stop using certificate

See if voms-proxy-info -timeleft works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output} =  Get proxy info  -timeleft
  Should Match Regexp  ${output}  ^[0-9]{1,6}$
  [Teardown]  Stop using certificate

See if voms --uri works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output} =  Get proxy info  -uri
  Should Match Regexp  ${output}  ${vo1_host}:\\d+
  [Teardown]  Stop using certificate

See if voms --serial works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output} =  Get proxy info  -serial
  Should Match Regexp  ${output}  (\\w+|\\d+)
  [Teardown]  Stop using certificate

See if voms-proxy-info -keyusage works
  [Setup]  Use certificate  test0
  [Tags]   remote  legacy
  Create voms proxy
  ${output} =  Get proxy info  -keyusage
  ${expected}=  Set Variable If  ${client_version} == 2  Digital Signature, Key Encipherment  Digital Signature, Non Repudiation, Key Encipherment
  Should Contain  ${output}  key usage : ${expected}
  [Teardown]  Stop using certificate

See if a proxy type is detected correctly
  [Setup]  Use certificate  test0
  [Tags]  legacy
  ${output}   Create proxy   -rfc 
  ${output}   Get proxy info  -type
  ${expected}=  Set Variable If  ${client_version} == 2  RFC compliant proxy  RFC3820 compliant impersonation proxy
  Should Contain  ${output}   ${expected}
  Destroy proxy
  ${output}   Create proxy   -old
  ${output}   Get proxy info  -type
  ${expected}=  Set Variable If  ${client_version} == 2  proxy  full legacy globus proxy
  Should Contain  ${output}  ${expected}
  Destroy proxy
  ${output}   Create proxy   -proxyver 3
  ${output}   Get proxy info  -type
  ${expected}=  Set Variable If  ${client_version} == 2  GT3-style proxy  Proxy draft (pre-RFC) impersonation proxy
  Should Contain  ${output}  ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-info --acexists works
  [Setup]  Use certificate  test0
  [Tags]  legacy
  Create voms proxy
  ${rc}  Run and Return RC  voms-proxy-info --acexists ${vo1}
  Should Be Equal As Integers  ${rc}  0
  ${rc}  Run and Return RC  voms-proxy-info --acexists foo
  Should Be Equal As Integers  ${rc}  1
  Create proxy
  ${rc}  Run and Return RC  voms-proxy-info --acexists ${vo1}
  Should Be Equal As Integers  ${rc}  1
  [Teardown]  Stop using certificate

See if voms-proxy-info works even if when no ac is present in proxy
  [Setup]  Use certificate  test0
  [Tags]  legacy
  Create plain proxy
  Get Proxy info
  [Teardown]  Stop using certificate

Check that voms-proxy-info timeleft options prints time in seconds
  [Tags]  regression  voms-proxy-info  legacy
  [Documentation]  Regression test for https://issues.infn.it/jira/browse/VOMS-296,%20https://issues.infn.it/jira/browse/VOMS-307.
  [Setup]  Use certificate  test0
  Create voms proxy
  ${output}  Get proxy info  --timeleft
  Should Not Contain  ${output}  :

Check that voms-proxy-info actimeleft options prints time in seconds
  [Tags]  regression  voms-proxy-info  legacy
  [Documentation]  Regression test for https://issues.infn.it/jira/browse/VOMS-296,%20https://issues.infn.it/jira/browse/VOMS-307.
  [Setup]  Use certificate  test0
  Create voms proxy
  ${output}  Get proxy info  --actimeleft
  Should Not Contain  ${output}  :

