*** Settings ***

Library   OperatingSystem
Library   Collections
Library   VOMSLibrary
Resource   variables.robot

*** Keywords ***

Execute and Check Success   [Arguments]   ${cmd}
  ${rc}   ${output}=   Run and Return RC And Output   ${cmd}
  Should Be Equal As Integers   ${rc}   0   ${output}   False
  RETURN   ${output}

Execute and Check Failure   [Arguments]   ${cmd}
  ${rc}   ${output}=   Run and Return RC And Output   ${cmd}
  Should Not Be Equal As Integers   ${rc}   0   ${output}
  RETURN   ${output}

Use p12 certificate   [Arguments]   ${cert}
  File Should Exist   ${certsDir}/${cert}.p12
  Stop using certificate
  Execute and Check Success   cp ${certsDir}/${cert}.p12 %{HOME}/.globus/usercred.p12
  Execute and Check Success   chmod 600 %{HOME}/.globus/usercred.p12

Use certificate   [Arguments]   ${cert}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  File Should Exist   ${certsDir}/${cert}.key.pem
  Stop using certificate
  Execute and Check Success   cp ${certsDir}/${cert}.cert.pem %{HOME}/.globus/usercert.pem
  Execute and Check Success   cp ${certsDir}/${cert}.key.pem %{HOME}/.globus/userkey.pem
  Execute and Check Success   chmod 400 %{HOME}/.globus/userkey.pem

Use mixed credentials   [Arguments]   ${cred1}  ${cred2}
  File Should Exist   ${certsDir}/${cred1}.cert.pem
  File Should Exist   ${certsDir}/${cred2}.key.pem
  Execute and Check Success   cp ${certsDir}/${cred1}.cert.pem %{HOME}/.globus/usercert.pem
  Execute and Check Success   cp ${certsDir}/${cred2}.key.pem %{HOME}/.globus/userkey.pem
  Execute and Check Success   chmod 400 %{HOME}/.globus/userkey.pem

Stop using certificate
  Run  rm %{HOME}/.globus/usercert.pem
  Run  rm -f %{HOME}/.globus/userkey.pem
  Run  rm -f %{HOME}/.globus/usercred.p12
  Run  voms-proxy-destroy

Get certificate subject   [Arguments]   ${certFile}
  File Should Exist   ${certFile}
  ${subject}   Execute and Check Success   openssl x509 -in ${certFile} -noout -subject | sed "s#subject= ##"
  RETURN   ${subject}

Get named certificate subject   [Arguments]   ${cert}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  ${subject}  Get certificate subject   ${certsDir}/${cert}.cert.pem
  RETURN   ${subject}
  
Get certificate start date   [Arguments]   ${certFile}
  File Should Exist   ${certFile}
  ${startDate}   Execute and Check Success   openssl x509 -in ${certFile} -noout -startdate | sed "s#notBefore=##"
  RETURN   ${startDate}

Get certificate end date   [Arguments]   ${certFile}
  File Should Exist   ${certFile}
  ${endDate}   Execute and Check Success   openssl x509 -in ${certFile} -noout -enddate | sed "s#notAfter=##"
  RETURN   ${endDate}

Get named certificate start date   [Arguments]   ${cert}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  ${startDate}   Get certificate start date   ${certsDir}/${cert}.cert.pem
  RETURN   ${startDate}

Get named certificate end date   [Arguments]   ${cert}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  ${endDate}   Get certificate end date   ${certsDir}/${cert}.cert.pem
  RETURN   ${endDate}

Get named certificate path   [Arguments]   ${cert}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  RETURN   ${certsDir}/${cert}.cert.pem

Get named p12 certificate path   [Arguments]   ${cert}
  File Should Exist   ${certsDir}/${cert}.p12
  RETURN   ${certsDir}/${cert}.p12

Create plain proxy
  Execute and Check Success   echo ${privateKeyPassword} | voms-proxy-init -pwstdin

Destroy proxy   [Arguments]   @{params}
  ${options}=  Get options list   @{params}
  Execute and Check Success   voms-proxy-destroy ${options}

Get options list   [Arguments]   @{params}
  ${optionsList}  Set Variable  ${EMPTY}
  FOR    ${option}   IN   @{params}
    ${optionsList} =  Catenate   ${optionsList}   ${option}
  END
  Log Many   ${optionsList}
  RETURN   ${optionsList}

Create voms proxy with roles   [Arguments]   @{roles}   
  Should Be True   ${roles}   Please provide at least one role   
  @{args}   Create List 
  FOR    ${r}   IN   ${roles}
    Append To List   ${args}   -voms ${vo1}:${r}
  END
  Log Many   @{args}   WARN
 
Get proxy info   [Arguments]   @{params}
   ${options}=  Get options list   @{params}
   ${output}=   Run   voms-proxy-info ${options}
   RETURN   ${output}
 
Get proxy openssl
   ${output}  Execute and Check Success  openssl x509 -in /tmp/x509up_u`id -u` -noout -text  
   RETURN  ${output}

Create proxy   [Arguments]   @{params}
   ${options}=  Get options list   @{params}
   ${output}   Execute and Check Success   echo ${privateKeyPassword}|voms-proxy-init -pwstdin ${options}
   RETURN   ${output}

Create proxy failure  [Arguments]   @{params}
   ${options}=  Get options list   @{params}
   ${output}   Execute and Check Failure   echo ${privateKeyPassword}|voms-proxy-init -pwstdin ${options}
   RETURN   ${output}

Create voms proxy   [Arguments]   ${vo}=${vo1}
  ${output}   Execute and Check Success   echo ${privateKeyPassword}|voms-proxy-init -pwstdin -voms ${vo}

Check voms-proxy-init failure   [Arguments]   ${failMessage}   ${vo}=${vo1}
  ${output}   Execute and Check Failure   echo ${privateKeyPassword}|voms-proxy-init -pwstdin -voms ${vo}
  Should Contain   ${output}   ${failMessage}
  RETURN   ${output}

Use admin certificate   [Arguments]  ${adminCert}=VO_Admin  
  Use certificate   VO_Admin
  Create plain proxy

Create user   [Arguments]   ${cert}  ${vo}=${vo1} 
  File Should Exist   ${certsDir}/${cert}.cert.pem
  Use admin certificate
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} create-user ${certsDir}/${cert}.cert.pem
  Stop using certificate

Delete user   [Arguments]  ${cert}   ${vo}=${vo1}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  Use admin certificate 
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} delete-user ${certsDir}/${cert}.cert.pem
  Stop using certificate

Create group   [Arguments]   ${groupName}   ${vo}=${vo1}
  Use admin certificate
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} create-group ${groupName}
  Stop using certificate

Delete group   [Arguments]   ${groupName}   ${vo}=${vo1}
  Use admin certificate
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} delete-group ${groupName}
  Stop using certificate

Create role   [Arguments]   ${roleName}   ${vo}=${vo1}
  Use admin certificate
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} create-role ${roleName}
  Stop using certificate

Delete role   [Arguments]   ${roleName}   ${vo}=${vo1}
  Use admin certificate
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} delete-role ${roleName}
  Stop using certificate

Add user to group    [Arguments]   ${cert}   ${groupName}   ${vo}=${vo1}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  Use admin certificate
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} add-member ${groupName} ${certsDir}/${cert}.cert.pem
  Stop using certificate

Remove user from group   [Arguments]   ${cert}   ${groupName}   ${vo}=${vo1}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  Use admin certificate
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} remove-member ${groupName} ${certsDir}/${cert}.cert.pem
  Stop using certificate

Assign role   [Arguments]   ${cert}   ${groupName}   ${roleName}   ${vo}=${vo1}
  File Should Exist   ${certsDir}/${cert}.cert.pem
  Use admin certificate
  Execute and Check Success   voms-admin --vo ${vo} --host ${vo1_host} assign-role ${groupName} ${roleName} ${certsDir}/${cert}.cert.pem 
  Stop using certificate

Proxy should exist
	${output}  Run  id -u
	File Should Exist   /tmp/x509up_u${output}

Get proxy path
	${userId}   Run   id -u
	RETURN   /tmp/x509up_u${userId}

Myproxy init  [Arguments]  @{params}
  ${options}=  Get options list   @{params}
  Execute and Check Success   echo ${myProxyPassPhrase}|myproxy-init -s ${myproxy_server} ${options} -S

Myproxy get delegation  [Arguments]   @{params}
  ${options}=  Get options list   @{params}
  ${output}  Execute and Check Success   echo ${myProxyPassPhrase}|myproxy-get-delegation -s ${myproxy_server} ${options} -S
  RETURN  ${output}

Myproxy info  [Arguments]   @{params}
  ${options}=  Get options list   @{params}
  ${output}  Execute and Check Success   myproxy-info -s ${myproxy_server} ${options}
  RETURN  ${output}

Myproxy destroy  [Arguments]   @{params}
  ${options}=  Get options list   @{params}
  ${output}  Execute and Check Success   myproxy-destroy -s ${myproxy_server} ${options}
  RETURN  ${output}

