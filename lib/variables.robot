*** Variables ***

${certsDir}   /usercerts
${privateKeyPassword}   pass
${customVomsdir}   /home/test/vomsdir

${vo1}   vo.0
${vo2}   vo.1
${vo1_host}  voms.test.example
${vo2_host}  voms.test.example
${vo1_issuer}  /C=IT/O=IGI/CN=voms.test.example
${vo2_issuer}  /C=IT/O=IGI/CN=voms.test.example
${vo1_legacy_fqan_enabled}   True
${vo2_legacy_fqan_enabled}   True
${vo1CorePort}  15001
${vo1_is_voms_aa}   False
${vo2_is_voms_aa}   False

${myproxy_server}  omii001.cnaf.infn.it
${myProxyPassPhrase}   123456
${srmEndpoint}   srm://omii005-vm03.cnaf.infn.it:8444/testers.eu-emi.eu

${client_version}  3
