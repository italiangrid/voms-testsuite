
VOMS testsuite
==============

A (temporary?) place for the VOMS testsuites. So far there are just a few tests for the CLI. More will follow. 

Prerequisites
=============

You need Robot Framework https://code.google.com/p/robotframework/.

You need the VOMS CLI, i.e. voms-proxy-* commands must be available.

Our tests certificates directory (https://github.com/valerioventuri/https-utils/tree/master/certs) must be copied somewhere on the filesystem.

Run the tests
=============

Execute the Robot Framework command-line passing the test certificates location in the certsDir variable  

    pybot --variable certsDir:/Users/valerioventuri/tmp/https-utils/certs tests.txt

