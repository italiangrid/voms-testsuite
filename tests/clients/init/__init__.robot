*** Settings ***

Library   OperatingSystem
Resource   lib/variables.robot
Resource   lib/vomslib.robot

*** Keywords ***

Setup VO 
  Log   "Executing test suite setup"   TRACE
  Create user   test0
  Create user   test1
  Create group  /${voName}/G1
  Create group  /${voName}/G2
  Create role   R1
  Create role   R2
  Add user to group   test0   /${voName}/G1
  Add user to group   test1   /${voName}/G2
  Assign role   test0   /${voName}/G1   R1
  

Teardown VO 
  Log   "Executing test suite teardown"   TRACE
  Delete user   test0
  Delete user   test1
  Delete group  /${voName}/G1
  Delete group  /${voName}/G2
  Delete role   R1
  Delete role   R2
