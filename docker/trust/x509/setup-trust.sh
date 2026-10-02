#!/bin/bash

set -e

if [ ! -e "openssl.conf" ]; then
  >&2 echo "The configuration file 'openssl.conf' doesn't exist in this directory"
  exit 1
fi

hostcerts_dir=/hostcerts
usercerts_dir=/usercerts
ta_dir=/trust-anchors
ca_bundle_prefix=/etc/pki

rm -rf "${hostcerts_dir}"
mkdir -p "${hostcerts_dir}"
rm -rf "${usercerts_dir}"
mkdir -p "${usercerts_dir}"
rm -rf "${ta_dir}"
mkdir -p "${ta_dir}"

export CA_NAME=igi_test_ca
export X509_CERT_DIR="${ta_dir}"

make_ca.sh

for c in voms-aa_test_example voms_test_example voms_test_example_ec; do
  make_cert.sh ${c}
  cp igi_test_ca/certs/${c}.* "${hostcerts_dir}"
  chmod 644 "${hostcerts_dir}"/${c}.cert.pem
  chmod 400 "${hostcerts_dir}"/${c}.key.pem
  chmod 600 "${hostcerts_dir}"/${c}.p12
done

chown 1000:1000 "${hostcerts_dir}"/*

for i in $(seq 0 6); do
  make_cert.sh test${i}
  cp igi_test_ca/certs/test${i}.* "${usercerts_dir}"
done

faketime -f -1y env make_cert.sh expired
cp igi_test_ca/certs/expired.* "${usercerts_dir}"

make_cert.sh revoked
cp igi_test_ca/certs/revoked.* "${usercerts_dir}"
revoke_cert.sh revoked

make_crl.sh
install_ca.sh igi_test_ca "${ta_dir}"

ca_bundle="${ca_bundle_prefix}"/tls/certs
cat "${ta_dir}"/igi_test_ca.pem >> "${ca_bundle}"/ca-bundle.crt

export CA_NAME=igi_test_ec_ca
make_ca.sh

for i in $(seq 7 8); do
  make_cert.sh test${i}
  cp igi_test_ec_ca/certs/test${i}.* "${usercerts_dir}"
done

chown 1000:1000 "${usercerts_dir}"/*

make_crl.sh
install_ca.sh igi_test_ec_ca "${ta_dir}"

ca_bundle="${ca_bundle_prefix}"/tls/certs
cat "${ta_dir}"/igi_test_ec_ca.pem >> "${ca_bundle}"/ca-bundle.crt
