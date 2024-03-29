** Settings ***

Library   OperatingSystem
Library   String
Resource  variables.robot

*** Variables ***

${ldapPort}  2170
${searchBase}  GLUE2GroupID=resource,o=glue

*** Keywords ***

Get voms-admin endpoint attribute  [Arguments]  ${attribute}
	[Documentation]  For each vo on a host, two GLUE2Endpoint are published, one for voms and one for voms-admin. This keyword return the value for the requested attribute for the voms-admin endpoint
	${output}  Run  ldapsearch -x -H ldap://${vo1_host}:${ldapPort} -b ${searchBase} '(&(objectClass=GLUE2Endpoint)(GLUE2EndpointInterfaceName=org.glite.voms-admin)(GLUE2EndpointURL=https://${vo1_host}:8443/voms/${vo1}))' ${attribute} | grep ${attribute}
	${attributeValue}  Fetch from right  ${output}  ${attribute}:
	${attributeValue}  Get substring  ${attributeValue}  1
	RETURN  ${attributeValue}

Get voms endpoint attribute  [Arguments]  ${attribute}
	[Documentation]  For each vo on a host, two GLUE2Endpoint are published, one for voms and one for voms-admin. This keywork return the value for the requested attribute for the voms endpoint
	${output}  Run  ldapsearch -x -H ldap://${vo1_host}:${ldapPort} -b ${searchBase} '(&(objectClass=GLUE2Endpoint)(GLUE2EndpointInterfaceName=org.glite.voms)(GLUE2EndpointURL=voms://${vo1_host}:${vo1CorePort}/${vo1}))' ${attribute} | grep ${attribute}
	${attributeValue}  Fetch from right  ${output}  ${attribute}:
	${attributeValue}  Get substring  ${attributeValue}  1
	RETURN  ${attributeValue}
