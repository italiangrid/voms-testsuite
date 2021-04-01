*** Settings ***
Resource   lib/vomslib.robot

*** Test Cases ***

See if voms-proxy-destroy -file works
  [Setup]  Use certificate  test0
  Create Proxy  --out /tmp/to_be_deleted
  Destroy Proxy  --file /tmp/to_be_deleted
  File Should Not Exist   /tmp/to_be_deleted
  [Teardown]  Stop using certificate

See if voms-proxy-destroy --dry works
  [Setup]  Use certificate  test0
  Create plain proxy
  Destroy proxy  --dry
  Proxy Should Exist
  [Teardown]  Stop using certificate


