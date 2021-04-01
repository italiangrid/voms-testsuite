*** Settings ***
Resource   lib/vomslib.txt

*** Test Cases ***

See if voms-proxy-init -noregen work as expected
  [Tags]  remote   rfc
  [Setup]   Use certificate   test0
  Create proxy   
  Execute And Check Success   voms-proxy-init -noregen -voms ${vo1}
  ${fqans}  Get proxy info   --fqan
  ${proxySubject}   Get proxy info   --subject
  ${certSubject}   Get named certificate subject   test0
  Should Match Regexp   ${proxySubject}   ${certSubject}/CN=[0-9]+/CN=[0-9]+
  Should Contain   ${fqans}   /${vo1}/Role=NULL/Capability=NULL
  [Teardown]   Stop using certificate

multiple voms-proxy-init -noregen work as expected
  [Tags]  remote  rfc
  [Setup]   Use certificate   test0
  Create proxy   -voms ${vo1}
  Create proxy   -noregen
  Create proxy   -noregen
  Create proxy   -noregen
  Create proxy   -noregen
  Create proxy   -noregen
  ${certificateSubject}   Get named certificate subject   test0
  ${subject}   Get proxy info   --subject
  ${fqans}   Get proxy info   --fqan
  Should Match Regexp  ${subject}  ${certificateSubject}(/CN=[0-9]+){6}
  Should Start With   ${fqans}  /${vo1}/Role=NULL/Capability=NULL 
  [Teardown]   Stop using certificate

See if voms-proxy-init --noregen of an rfc proxy works
  [Tags]  remote
  [Setup]  Use certificate   test0
  Create Proxy  -rfc
  Create Proxy  -noregen -voms ${vo1}
  ${info}   Get proxy info   --all
  Should Contain   ${info}   RFC3820 compliant impersonation proxy
  [Teardown]  Stop using certificate

See if voms-proxy-init --noregen works (no attribute fetching)
  [Tags]  remote  rfc
  [Setup]   Use certificate   test0
  ${output}  Create voms proxy
  ${output}   Create proxy   -noregen 
  Should Contain  ${output}  Created proxy
  ${output} =  Get proxy info  -chain
  Should Match Regexp  ${output}   Subject:\\s+(CN=[0-9]+,){2}CN=.*
  [Teardown]   Stop using certificate

