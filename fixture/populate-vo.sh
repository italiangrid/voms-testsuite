#!/bin/bash
set -ex

[ $# -eq 1 ] || ( echo "Usage: $0 VO_NAME"; exit 1 ) 

# Where test certs are looked for
TEST_CERTS_PATH=/usr/share/igi-test-ca

# Name of the VO which will get the fixture
VO=$1

get_cert(){

        echo "$TEST_CERTS_PATH/$1.cert.pem"
}

TEST0_CERT=`get_cert test0`
TEST1_CERT=`get_cert test1`
PARENS=`get_cert dn_with_parenthesis`

G1=/$VO/G1
G2=/$VO/G2
G3=/$VO/G2/G3
G4=/$VO/G1/G4
G5=/$VO/G1/G4/G5

voms-admin --vo $VO create-user $TEST0_CERT 
voms-admin --vo $VO create-user $TEST1_CERT 
voms-admin --vo $VO create-user $PARENS 
voms-admin --vo $VO create-group $G1
voms-admin --vo $VO create-group $G2 
voms-admin --vo $VO create-group $G3
voms-admin --vo $VO create-group $G4 
voms-admin --vo $VO create-group $G5 
voms-admin --vo $VO create-role R1
voms-admin --vo $VO create-role R2
voms-admin --vo $VO create-role R3
voms-admin --vo $VO add-member $G1 $TEST0_CERT
voms-admin --vo $VO add-member $G3 $TEST0_CERT 
voms-admin --vo $VO add-member $G2 $TEST1_CERT
voms-admin --vo $VO add-member $G5 $TEST1_CERT
voms-admin --vo $VO assign-role $G1 R1 $TEST0_CERT
voms-admin --vo $VO assign-role $G2 R1 $TEST0_CERT
