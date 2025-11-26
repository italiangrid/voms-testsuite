*** Settings ***
Resource   lib/vomslib.robot
Resource   lib/variables.robot
Documentation  Generic tests for voms-proxy-init

*** Keywords ***

Setup mixed proxy chain
  Use certificate   test0
  Create proxy   
  Create proxy   -rfc --skip_chain_integrity_checks -noregen
  Create proxy   -noregen -proxyver 3 --skip_chain_integrity_checks

*** Test Cases ***

See if voms-proxy-init --version returns after displaying the version
  [Tags]  legacy
  ${output}  Create Proxy  --version
  ${expected}  Set Variable If  ${client_version} == 2  voms-proxy-init\nVersion: \\w  voms-proxy-init v. \\w
  Should Match Regexp  ${output}  ${expected}

See if voms-proxy-init correctly set unlimited pathLen by default for rfc proxies
  [Documentation]   Regression test for https://issues.infn.it:8443/browse/VOMS-256
  [Tags]   debug  legacy
  [Setup]   Use certificate   test0
  Create Proxy   --rfc
  ${output}   Get proxy openssl
  Should Match Regexp   ${output}  Path Length Constraint: infinite 
  [Teardown]  Stop using certificate

See if voms-proxy-init correctly set pathLen as requested 
  [Documentation]   Regression test for https://issues.infn.it:8443/browse/VOMS-256
  [Tags]   debug  legacy
  [Setup]   Use certificate   test0
  ${option}  Set Variable If  ${client_version} == 2  --path-length  --path_length
  Create Proxy   --rfc ${option} 1
  ${output}   Get proxy openssl
  Should Match Regexp   ${output}   Path Length Constraint: 01
  [Teardown]  Stop using certificate

See if a requested role ends up as primary fqan
  [Tags]  remote  legacy
  [Setup]   Use certificate   test0
  Create proxy   --voms ${vo1}:/${vo1}/G1/Role=R1
  ${output}  Get proxy info   --fqan
  ${primary_fqan}=   Set Variable If   ${vo1_legacy_fqan_enabled} == True   /${vo1}/G1/Role=R1/Capability=NULL   /${vo1}/G1/R1
  Should Start With   ${output}   ${primary_fqan}
  [Teardown]  Stop using certificate

See if multiple -voms work as expected
  [Tags]  remote  legacy
  [Setup]   Use certificate   test0
  Create proxy   --voms ${vo1}:/${vo1}/G1 --voms ${vo1}:/${vo1}/G1/Role=R1 
  ${output}  Get proxy info   --fqan
  ${voms_role}=   Set Variable If   ${vo1_legacy_fqan_enabled} == True   /${vo1}/G1/Role=NULL/Capability=NULL   /${vo1}/G1
  Should Start With   ${output}   ${voms_role}
  ${voms_role}=   Set Variable If   ${vo1_legacy_fqan_enabled} == True   /${vo1}/G1/Role=R1/Capability=NULL   /${vo1}/G1/R1
  Should Contain   ${output}   ${voms_role}
  [Teardown]  Stop using certificate

See if request for multiple VOs work as expected
  [Tags]  remote  legacy
  [Documentation]   ACs for multiple VOs should be included in the proxy in the same order as they are requested
  [Setup]   Use certificate   test0
  Create proxy   --voms ${vo2} --voms ${vo1} 
  ${output}  Get proxy info   --fqan
  ${expected}=   Set Variable If   ${vo2_legacy_fqan_enabled} == True   /${vo2}/Role=NULL/Capability=NULL   /${vo2}
  Should Start With   ${output}   ${expected}
  ${expected}=   Set Variable If   ${vo1_legacy_fqan_enabled} == True   /${vo1}/Role=NULL/Capability=NULL   /${vo1}
  Should Contain   ${output}   ${expected}
  [Teardown]   Stop using certificate

voms-proxy-init can parse p12 certificates
  [Setup]   Use p12 certificate   test0
  [Tags]   rfc  legacy
  Create proxy 
  ${proxySubject}   Get proxy info   --subject
  ${certSubject}   Get named certificate subject   test0
  Should Match Regexp    ${proxySubject}   ${certSubject}/CN=[0-9]+
  [Teardown]   Stop using certificate

voms-proxy-init -cert option understands p12 certificates
  [Tags]   rfc
  ${cert}   Get named p12 certificate path   test0
  ${tmpCert}   Run   mktemp /tmp/voms-p12testXXX
  Execute and Check Success   cp ${cert} ${tmpCert}
  Execute and Check Success   chmod 600 ${tmpCert}
  Create proxy   -cert ${tmpCert}
  ${proxySubject}   Get proxy info   --subject
  ${certSubject}   Get named certificate subject   test0
  Should Match Regexp   ${proxySubject}   ${certSubject}/CN=[0-9]+
  [Teardown]   Stop using certificate

voms-proxy-init generates proxy with the appropriate file permissions
  [Tags]  legacy
  [Setup]   Use certificate   test0
  Create proxy
  ${proxyFile}   Get proxy path
  ${lsOutput}   Run   ls -l ${proxyFile}
  Should start with   ${lsOutput}   -rw------
  [Teardown]   Stop using certificate

voms-proxy-init enforces chain integrity
  [Tags]   rfc   java-clients
  [Setup]   Use certificate   test0
  Create proxy   -old   
  ${output}   Create proxy   -noregen -rfc
  Should Contain   ${output}   forced LEGACY proxy type to be compatible with the type of the issuing proxy.
  ${type}   Get proxy info   --type
  Should Be Equal   ${type}   full legacy globus proxy
  Destroy proxy
  Create proxy 
  ${output}   Create proxy   -noregen  -old
  Should Contain   ${output}   forced RFC3820 proxy type to be compatible with the type of the issuing proxy.
  ${type}   Get proxy info   --type
  Should Be Equal   ${type}   RFC3820 compliant impersonation proxy
  [Teardown]   Stop using certificate

limited proxies can sign only limited proxies
  [Tags]   rfc   java-clients
  [Setup]   Use certificate   test0
  Create proxy   -limited -old
  ${output}   Create proxy   -noregen
  Should Contain   ${output}   forced the creation of a limited proxy to be compatible with the type of the issuing proxy.
  ${type}   Get proxy info   --type
  Should Be Equal   ${type}   limited legacy globus proxy
  Destroy proxy
  Create proxy   -rfc -limited
  ${output}   Create proxy   -noregen
  Should Contain   ${output}   forced the creation of a limited proxy to be compatible with the type of the issuing proxy.
  ${type}   Get proxy info   --type
  Should Be Equal   ${type}   RFC3820 compliant limited proxy
  [Teardown]   Stop using certificate

voms-proxy-init --order cannot force role requests
  [Tags]  remote  legacy
  [Setup]   Use certificate   test0
  Create proxy   -voms ${vo1} -order /${vo1}/G1/Role=R1 -order /${vo1}/G1
  ${output}   Get proxy info   --fqan
  ${expected}=  Set Variable If  ${vo1_legacy_fqan_enabled} == True  /${vo1}/G1/Role=NULL/Capability=NULL  /${vo1}/G1
  Should Start With   ${output}   ${expected}
  ${expected}=  Set Variable If  ${vo1_legacy_fqan_enabled} == True  /${vo1}/G1/Role=R1/Capability=NULL  /${vo1}/G1/R1
  Should Not Contain   ${output}   ${expected}
  [Teardown]   Stop using certificate

long delegation chain work as expected
  [Tags]   dev,remote  legacy
  [Setup]   Use certificate   test0
  Create proxy
  Create proxy   -noregen -hours 11
  Create proxy   -noregen -hours 10
  Create proxy   -noregen -hours 9
  Create proxy   -noregen -hours 8
  ${output}   Create proxy   -voms ${vo1}
  [Teardown]   Stop using certificate

See if AC validation works when LSC file exists
  [Tags]  legacy
  [Setup]  Use certificate   test0
  Create voms proxy
  [Teardown]  Stop using certificate

See if voms-proxy-init --dont_verify_ac works
  [Tags]  remote  legacy
  [Setup]  Use certificate   test0
  ${option}  Set Variable If  ${client_version} == 2  --dont-verify-ac  --dont_verify_ac
  ${output}  Create Proxy   -debug -voms ${vo1} ${option}
  Should Not Contain  ${output}  VOMS AC validation for VO ${vo1} succeded 
  [Teardown]  Stop using certificate

Check that voms-proxy-init requesting more than two FQANs works as expected
  [Tags]  remote  legacy
  [Setup]  Use certificate   test0
  Create Proxy  -voms ${vo1}:/${vo1}/G1/Role=R1 -voms ${vo1}:/${vo1}/G1 -voms ${vo1}:/${vo1}
  [Teardown]  Stop using certificate

A user can get a proxy from a VO she belongs to
  [Tags]  remote  legacy
  [Setup]   Use certificate   test0
  Create voms proxy
  [Teardown]   Stop using certificate 

A user cannot obtain a proxy with an expired certificate
  [Tags]  remote  legacy
  [Setup]   Use certificate   expired
  Check voms-proxy-init failure   expired
  [Teardown]   Stop using certificate

A user cannot obtain a proxy with a revoked certificate
  [Tags]  remote  legacy
  [Setup]   Use certificate   revoked
  Check voms-proxy-init failure   revoked
  [Teardown]   Stop using certificate

A user can obtain a role she holds from a VO she belongs to
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  Create proxy   -voms ${vo1}:/${vo1}/G1/Role=R1
  ${output}  Get proxy info  -fqan
  Should Contain  ${output}  /${vo1}/G1/Role=R1
  [Teardown]  Stop using certificate

See if voms-proxy-init --hours works
  [Tags]  legacy
  [Setup]   Use certificate   test0
  ${output}   Create proxy   -hours 3
  ${expected}   Set Variable If  ${client_version} == 2  Creating proxy \.+ Done  Created proxy
  Should Match Regexp  ${output}  ${expected}
  ${output} =  Get proxy info  --timeleft
  ${result} =  Convert to integer  ${output}
  Should be true  ${result} > 10000
  Create Proxy  --hours 40
  ${output}  Get proxy info  --timeleft
  ${result} =  Convert to integer  ${output}
  Should be true  ${result} > 140000
  [Teardown]  Stop using certificate

See if voms-proxy-init --old works
  [Tags]  legacy
  [Setup]   Use certificate   test0
  ${output}   Create proxy   -old
  ${output}   Execute and Check Success   voms-proxy-info
  ${expected}  Set Variable If  ${client_version} == 2  proxy  full legacy globus proxy
  Should Match Regexp  ${output}  type\\s+:\\s+${expected}
  [Teardown]   Stop using certificate

See if voms-proxy-init detects fake arguments
  [Tags]  legacy
  [Setup]  Use certificate  test0
  ${output}   Create proxy failure  --voms voms1 junk
  ${expected}  Set Variable If  ${client_version} == 2  junk  Check your vomses configuration
  Should Contain  ${output}  ${expected}
  [Teardown]  Stop using certificate

See if requesting a too long proxy fails
  [Tags]  remote  legacy  issue-724
  [Setup]  Use certificate  test0
  ${output}   Create proxy   --voms ${vo1} --valid 100:00
  Should Contain  ${output}  The validity of this VOMS AC in your proxy is shortened to
  [Teardown]  Stop using certificate

Can AC validity be limited?
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  ${output}   Create proxy   --voms ${vo1} --vomslife 5:00
  ${output}   Get proxy info  -all
  Should Match Regexp  ${output}  timeleft\\s+:\\s+(11|12):\\d+:\\d+
  Should Match Regexp  ${output}  timeleft\\s+:\\s+0?(4|5):\\d+:\\d+
  [Teardown]  Stop using certificate

See if requesting a too long ac length fails
  [Tags]  remote  legacy  issue-724
  [Setup]  Use certificate  test0
  ${output}   Create proxy   --voms ${vo1} --vomslife 100:00
  Should Contain  ${output}  The validity of this VOMS AC in your proxy is shortened to
  [Teardown]  Stop using certificate

See if a target can be added to a proxy
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  ${target}  Run   hostname -f
  ${output}  Create proxy  -voms ${vo1} -target ${target}
  Should Not Contain   ${output}  AC target check failed
  [Teardown]  Stop using certificate

voms-proxy-init should limit proxy lifetime to be consistent with issuing certificate lifetime
  [Tags]   java-clients
  [Setup]   Use certificate   test0
  ${output}   Create proxy   --hours  96426
  Should Contain   ${output}   proxy lifetime limited to issuing credential lifetime
  ${certEndTime}   Get named certificate end date   test0
  ${proxyPath}   Get proxy path
  ${proxyEndTime}   Get certificate end date   ${proxyPath}
  ${rc}   Compare Dates   ${proxyEndTime}   ${certEndTime}
  Should Be True   ${rc} == -1 or ${rc} == 0
  ${rc}   Date Difference In Seconds   ${proxyEndTime}   ${certEndTime}
  Should Be True   ${rc} < 10
  [Teardown]   Stop using certificate

See if voms-proxy-init read timeout works
  [Tags]   read-timeout
  [Setup]  Use certificate  test0
  ${beginLiteral}  Get Time  epoch
  ${begin}  Convert To Integer  ${beginLiteral}
  ${output}  Create proxy failure  --voms bane --timeout 1
  ${endLiteral}  Get Time  epoch
  ${end}  Convert To Integer  ${endLiteral}
  ${time}  Evaluate  ${end}-${begin}
  Should Contain  ${output}  Read timed out
  # besides connecting, voms-proxy-init needs two secs to do its business,
  # and there's two connections to try, so total time should be around 4s
  ${result}  Evaluate  ${time} < 8
  Should Be True  ${result}
  [Teardown]  Stop using certificate

See if voms-proxy-init connect timeout works
  [Tags]  connect-timeout
  [Setup]  Use certificate  test0
  ${beginLiteral}  Get Time  epoch
  ${begin}  Convert To Integer  ${beginLiteral}
  ${tmpVomses}   Run   mktemp /tmp/vomsesXXX
  Execute and Check Success   echo \\"timeout\\" \\"10.255.255.1\\" \\"81\\" \\"${vo1_issuer}\\" \\"timeout\\" > ${tmpVomses}
  ${output}  Create proxy failure  --voms timeout --timeout 1 --vomses ${tmpVomses}
  ${endLiteral}  Get Time  epoch
  ${end}  Convert To Integer  ${endLiteral}
  ${time}  Evaluate  ${end}-${begin}
  ${expected}  Set Variable If  ${client_version} == 2  None of the contacted servers for timeout were capable  connect timed out
  Should Contain  ${output}  ${expected}
  # besides connecting, voms-proxy-init needs two secs to do its business,
  # and there's two connections to try, so total time should be around 4s
  Should Be True   ${time} < 8
  [Teardown]  Stop using certificate

See if voms does not allow expansion of credential set from an AC
  [Tags]  remote  legacy  issue-726
  [Setup]  Use certificate  test0
  Create proxy   -voms ${vo1}
  ${voms_role}=  Set Variable If  ${vo1_legacy_fqan_enabled} == True   /${vo1}/G1/Role=R1   /${vo1}/G1/R1
  Create proxy   -voms ${vo1}:${voms_role} --valid 10:00 --noregen
  ${output}  Get proxy info  -all
  Should Not Contain   ${output}  ${voms_role}
  [Teardown]  Stop using certificate

See if voms does not allow expansion of credential set from a proxy
  [Tags]  remote  legacy  issue-726
  [Setup]  Use certificate  test0
  Create proxy
  ${voms_role}=  Set Variable If  ${vo1_legacy_fqan_enabled} == True   /${vo1}/G1/Role=R1   /${vo1}/G1/R1
  Create proxy   -voms ${vo1}:${voms_role} --valid 10:00 --noregen
  ${output}  Get proxy info  -all
  Should Not Contain   ${output}  ${voms_role}
  [Teardown]  Stop using certificate

See if voms-proxy-init --debug works
  [Tags]  remote  legacy
  [Setup]  Use certificate  test0
  ${output}  Create proxy  --voms ${vo1} --debug
  IF  ${client_version} == 2
    Should Contain  ${output}  Files being used:
  ELSE
    Should Contain  ${output}  Looking for user credentials in
    Should Contain  ${output}  Credentials loaded successfully
    Should contain  ${output}  Loading CA Certificate
    Should contain  ${output}  Looking for VOMSES information in
    Should contain  ${output}  Loaded vomses information
    Should contain  ${output}  Contacting
    Should contain  ${output}  Sent HTTP request for
    Should contain  ${output}  Received VOMS response:
    Should contain  ${output}  Remote VOMS server contacted succesfully.
    Should contain  ${output}  Looking for VOMS AA certificates in 
    Should contain  ${output}  Looking for LSC information in 
    Should contain  ${output}  Loaded LSC information from file
    Should contain  ${output}  VOMS AC validation for
  END
  [Teardown]  Stop using certificate
  
See if voms-proxy-init works using a 600 userkey
  [Tags]  legacy
  [Setup]   Use certificate   test0
  Execute and Check Success   chmod 600 %{HOME}/.globus/userkey.pem
  ${output}   Create proxy
  [Teardown]   Stop using certificate

voms-proxy-init fails validation for malformed LSC
  [Tags]  voms-api-java-issue-47
  [Setup]  Use certificate  test0
  ${output}   Create proxy failure  --voms ${vo1} -vomsdir /home/test/vomsdir
  ${expected}  Set Variable If  ${client_version} == 2  Unable to match certificate chain against file  Malformed LSC file
  Should Contain  ${output}  ${expected}
  [Teardown]  Stop using certificate

voms-proxy-init fails validation for malformed LSC when multiple VOs are requested
  [Tags]  voms-api-java-issue-47
  [Setup]  Use certificate  test0
  ${output}   Create proxy failure  --voms ${vo1} --voms ${vo2} -vomsdir /home/test/vomsdir
  ${expected}  Set Variable If  ${client_version} == 2  Unable to match certificate chain against file  Malformed LSC file
  Should Contain  ${output}  ${expected}
  [Teardown]  Stop using certificate

voms-proxy-init --dont_verify_ac succeeds with malformed LSC
  [Tags]   legacy
  [Setup]  Use certificate   test0
  ${option}  Set Variable If  ${client_version} == 2  --dont-verify-ac  --dont_verify_ac
  ${output}  Create Proxy   -debug --voms ${vo1} -vomsdir /home/test/vomsdir ${option}
  Should Not Contain  ${output}  VOMS AC validation for VO malformed succeded
  [Teardown]  Stop using certificate
