# VOMS testsuite

A place for the VOMS testsuites. So far there are just a few tests for the CLI. More will follow. 

# Requirements

- Robot Framework https://code.google.com/p/robotframework/.
- The voms clients package installed, i.e. voms-proxy-* commands must be available.
- The `$HOME/.globus` directory should exist for the user that runs the test suite and should be *EMPTY*.
- The `$HOME/.glite/vomses` and `$HOME/.voms/vomses` directories could be wiped out by the testsuite, so
if you have sensible information there save it somewhere else.
- The test certificates must be available on the machine where the testsuite is run. Certificates
can be installed from an [RPM] [1] or fetching the [code from github] [2] and placing the CA certs
in /etc/grid-security/certificates and the certificate files where you prefer.


# Getting the testsuite 


To run this testsuite, checkout the code using the following command:

    git clone git://github.com/andreaceccanti/voms-testsuite.git


# Run the `regression` test suite

Execute the Robot Framework command-line passing the test certificates location in the certsDir variable:  
        
    pybot --variable certsDir:/path/to/certs regression

in the directory where you have checkout the testsuite code.

# Run the `basic-tests` test suite 

The `basic-tests` test suite requires that you have a VOMS and VOMS-Admin service up & running on a given
endpoint which hosts a VO where the VO-Admin test certificate has administrative privileges.
You will also need the local clients configured to talk to such VOMS server. 
This means that vomsdir and vomses configuration must be in place. Consult the VOMS clients documentation
on how to setup correctly the clients.

To run the basic test suite, execute the Robot Framework command-line passing the following options 
depending on your test setup:
    
    pybot --variable certsDir:/path/to/certs \
          --variable voName:NameOfTheTestVo  \
          --variable vomsHost:HostWhereTestVomsIsRunning \
          basic-tests


[1]: http://radiohead.cnaf.infn.it:9999/job/test-ca/os=SL5_x86_64/lastSuccessfulBuild/artifact/igi-test-ca/rpmbuild/RPMS/noarch/igi-test-ca-1.0.0-1.sl5.noarch.rpm  "The test certificates RPM package"
[2]: https://github.com/andreaceccanti/test-ca/tree/master/igi-test-ca  "The test certificates on Github"
