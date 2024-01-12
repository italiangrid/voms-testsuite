*** Variables ***

${certsDir}   /usr/share/igi-test-ca
${privateKeyPassword}   pass

${vo1}   test.vo
${vo2}  test.vo.2
${vo1_host}  vgrid02.cnaf.infn.it 
${vo2_host}  vgrid02.cnaf.infn.it
${vo1_issuer}  /DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=vgrid02.cnaf.infn.it
${vo2_issuer}  /DC=org/DC=terena/DC=tcs/C=IT/ST=Roma/O=Istituto Nazionale di Fisica Nucleare/CN=vgrid02.cnaf.infn.it
${vo1_legacy_fqan_enabled}   True
${vo2_legacy_fqan_enabled}   True
${vo1CorePort}  15001

${myproxy_server}  omii001.cnaf.infn.it
${myProxyPassPhrase}   123456
${srmEndpoint}   srm://omii005-vm03.cnaf.infn.it:8444/testers.eu-emi.eu

${client_version}  3
