*** Settings ***
Resource   lib/infosys.robot
Documentation  Tests information published in the resource bdii

*** Test Cases ***

Check value of GLUE2EndpointHealtState for voms-admin
  [Documentation]  Check that the service endpoint for voms-admin publish ok for GLUE2EndpointHealtState
  ${info}  Get voms-admin endpoint attribute  GLUE2EndpointHealthState
	Should contain  ${info}  ok

Check value of GLUE2EndpointHealtState for voms
  [Documentation]  Check that the service endpoint for voms publish ok for GLUE2EndpointHealtState
  ${info}  Get voms endpoint attribute  GLUE2EndpointHealthState
	Should contain  ${info}  ok

Check value of GLUE2EndpointHealthStateInfo from voms-admin
	[Tags]  regression
  [Documentation]  Regression test for https://issues.infn.it/jira/browse/VOMS-383
  ${info}  Get voms-admin endpoint attribute  GLUE2EndpointHealthStateInfo
	Should contain  ${info}  OK

Check value of GLUE2EndpointHealthStateInfo from voms
  ${info}  Get voms endpoint attribute  GLUE2EndpointHealthStateInfo
	Should contain  ${info}  Status voms(${vo1}): is running...
