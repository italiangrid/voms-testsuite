*** Variables ***

${certsDir}   /usr/share/igi-test-ca
${privateKeyPassword}   pass

${vo1}   test.vo
${vo2}  test.vo.2
${vo1_host}  vgrid02.cnaf.infn.it 
${vo2_host}  vgrid02.cnaf.infn.it
${vo1_issuer}  /DC=org/DC=terena/DC=tcs/C=IT/L=Frascati/O=Istituto Nazionale di Fisica Nucleare/OU=CNAF/CN=vgrid02.cnaf.infn.it
${vo2_issuer}  /DC=org/DC=terena/DC=tcs/C=IT/L=Frascati/O=Istituto Nazionale di Fisica Nucleare/OU=CNAF/CN=vgrid02.cnaf.infn.it
${vo1CorePort}  15001

${myproxy_server}  omii001.cnaf.infn.it
${myProxyPassPhrase}   123456
${srmEndpoint}   srm://omii005-vm03.cnaf.infn.it:8444/testers.eu-emi.eu
