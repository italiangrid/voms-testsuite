# Library

Library for VOMS related tasks, setting user credentials, creating proxies, etc.

## Keywords

## Get proxy openssl

Issues openssl x509 on the proxy certificate file in /tmp, returning the text representation (--noout --text), that can be checked as in 

```bash
See if voms-proxy-init --bits works
	[Setup]  Use certificate  test0
	Create Proxy  --bits 512
	${output}  Get proxy openssl
	Should Contain  ${output}  Public-Key: (512 bit)
	[Teardown]  Stop using certificate
```

## Proxy should exists

Check that a proxy exists in the default location, as in

```bash
See if voms-proxy-destroy --dryrun works
	[Setup]  Use certificate  test0
	Create plain proxy
	Proxy Should Exist
	[Teardown]  Stop using certificate
```
