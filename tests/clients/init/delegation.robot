*** Settings ***
Resource   lib/vomslib.robot

*** Test Cases ***

See if voms-proxy-init -noregen work as expected
  [Tags]  remote   rfc  legacy
  [Setup]   Use certificate   test0
  Create proxy   -hours 24
  Execute And Check Success   voms-proxy-init -noregen -voms ${vo1}
  ${fqans}  Get proxy info   --fqan
  ${proxySubject}   Get proxy info   --subject
  ${certSubject}   Get named certificate subject   test0
  Should Match Regexp   ${proxySubject}   ${certSubject}/CN=[0-9]+/CN=[0-9]+
  ${expected}=  Set Variable If  ${vo1_legacy_fqan_enabled} == True  /${vo1}/Role=NULL/Capability=NULL   /${vo1}
  Should Contain   ${fqans}   ${expected}
  [Teardown]   Stop using certificate

multiple voms-proxy-init -noregen work as expected
  [Tags]  remote  rfc  legacy
  [Setup]   Use certificate   test0
  Create proxy   -voms ${vo1} -hours 24
  Create proxy   -noregen -hours 23
  Create proxy   -noregen -hours 22
  Create proxy   -noregen -hours 21
  Create proxy   -noregen -hours 20
  Create proxy   -noregen -hours 19
  ${certificateSubject}   Get named certificate subject   test0
  ${subject}   Get proxy info   --subject
  ${fqans}   Get proxy info   --fqan
  Should Match Regexp  ${subject}  ${certificateSubject}(/CN=[0-9]+){6}
  ${expected}=   Set Variable If  ${vo1_legacy_fqan_enabled} == True   /${vo1}/Role=NULL/Capability=NULL   /${vo1}
  Should Start With   ${fqans}  ${expected}
  [Teardown]   Stop using certificate

See if voms-proxy-init --noregen of an rfc proxy works
  [Tags]  remote  legacy
  [Setup]  Use certificate   test0
  Create Proxy  -rfc -hours 24
  Create Proxy  -noregen -voms ${vo1}
  ${info}   Get proxy info   --all
  ${expected}   Set Variable If  ${client_version} == 2  RFC compliant proxy  RFC3820 compliant impersonation proxy
  Should Contain   ${info}  ${expected}
  [Teardown]  Stop using certificate

See if voms-proxy-init --noregen works (no attribute fetching)
  [Tags]  remote  rfc  legacy
  [Setup]   Use certificate   test0
  ${output}  Create voms proxy
  ${output}   Create proxy   -noregen -hours 11
  ${expected}   Set Variable If  ${client_version} == 2  Creating proxy \.\+ Done  Created proxy
  Should Match Regexp  ${output}  ${expected}
  ${output} =  Get proxy info  -chain
  ${expected}   Set Variable If  ${client_version} == 2  subject\\s*:\\s/.+/CN=.*/CN=[0-9]+/CN=[0-9]+\n  Subject:\\s+(CN=[0-9]+,){2}CN=.*
  Should Match Regexp  ${output}  ${expected}
  [Teardown]   Stop using certificate

