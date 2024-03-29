*** Settings ***
Resource   lib/vomslib.robot


*** Keywords ***

Teardown for myproxy tests
  Create Proxy
  Myproxy destroy
  Stop using certificate

*** Test Cases ***

Check delegation works after uploading credential by using a voms proxy
  [Tags]   myproxy
  [Setup]  Use certificate  test0
  Create voms proxy   ${vo1}
  ${proxyName}  Get Proxy info  -path
  Myproxy init  -v --certfile ${proxyName} --keyfile ${proxyName}
  ${output}  Myproxy get delegation  -v
  Log  ${output}
  [Teardown]  Teardown for myproxy tests

Check delegation works after uploading credential by using a grid proxy
  [Tags]   myproxy
  [Setup]  Use certificate  test0
  Create Proxy
  ${proxyName}  Get Proxy info  -path
  Myproxy init  -v --certfile ${proxyName} --keyfile ${proxyName}
  ${output}  Myproxy get delegation  -v
  Log  ${output}
  [Teardown]  Teardown for myproxy tests

Check delegation works when a grid proxy is used to upload/get credential
  [Tags]   myproxy
  [Setup]  Use certificate  test0
  ${cred_to_renew}   Run   mktemp /tmp/voms-cred-to-renewXXX
  Create Proxy  -out ${cred_to_renew}
  Myproxy init  --certfile ${cred_to_renew} --keyfile ${cred_to_renew} -A -a
  ${output}  Myproxy get delegation  -v -a ${cred_to_renew}
  Log  ${output}
  [Teardown]  Teardown for myproxy tests

Check delegation works when a grid delegated proxy is used to upload/get credential
  [Tags]   myproxy
  [Setup]  Use certificate  test0
  ${cred_to_renew}   Run   mktemp /tmp/voms-cred-to-renewXXX
  Create Proxy
  Create Proxy  -noregen -out ${cred_to_renew}
  Destroy proxy
  Myproxy init  --certfile ${cred_to_renew} --keyfile ${cred_to_renew} -A -a
  ${output}  Myproxy get delegation  -v -a ${cred_to_renew}
  Log  ${output}
  [Teardown]  Teardown for myproxy tests

Check delegation works when a voms proxy is used to upload/get credential
  [Tags]   myproxy
  [Setup]  Use certificate  test0
  ${cred_to_renew}   Run   mktemp /tmp/voms-cred-to-renewXXX
  Create Proxy  ${vo1} -out ${cred_to_renew}
  Myproxy init  -v --certfile ${cred_to_renew} --keyfile ${cred_to_renew} -A -a 
  ${output}  Myproxy get delegation  -v -a ${cred_to_renew} --voms ${vo1}
  Log  ${output}
  [Teardown]  Teardown for myproxy tests

Check delegation works when a voms delegated proxy is used to upload/get credential 
  [Tags]   myproxy
  [Setup]  Use certificate  test0
  ${cred_to_renew}   Run   mktemp /tmp/voms-cred-to-renewXXX
  Create Proxy
  Create Proxy  ${vo1} -noregen -out ${cred_to_renew}
  Destroy proxy
  Myproxy init  -v --certfile ${cred_to_renew} --keyfile ${cred_to_renew} -A -a
  ${output}  Myproxy get delegation  -v -a ${cred_to_renew} --voms ${vo1}
  Log  ${output}
  [Teardown]  Teardown for myproxy tests
