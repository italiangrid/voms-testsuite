*** Variables ***

${certsDir}   /usr/share/igi-test-ca
${privateKeyPassword}   pass

${vo1}   vo.0
${vo2}   vo.1
${vo1_host}  dev.local.io 
${vo2_host}  dev.local.io
${vo1_issuer}  /C=IT/O=IGI/CN=*.local.io
${vo2_issuer}  /C=IT/O=IGI/CN=*.local.io
${vo1CorePort}  15001

${myproxy_server}  omii001.cnaf.infn.it
${myProxyPassPhrase}   123456
${srmEndpoint}   srm://omii005-vm03.cnaf.infn.it:8444/testers.eu-emi.eu
