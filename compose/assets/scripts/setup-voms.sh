#!/bin/bash
set -ex
trap "exit 1" TERM

VOMS_HOST=${VOMS_HOST:-voms.test.example}

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

ASSETS="/voms-testsuite/compose/assets"

yum -y install voms-mysql-plugin voms-server
echo "VOMS version: $(rpm -q voms)"

source /etc/sysconfig/voms
VOMS_USER=${VOMS_USER:-voms}

# Add voms user to the sudoers
echo ${VOMS_USER} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${VOMS_USER}
chmod 0440 /etc/sudoers.d/${VOMS_USER}

# Setup host certificate
cp /hostcerts/voms_test_example.cert.pem /etc/grid-security/vomscert.pem
cp /hostcerts/voms_test_example.key.pem /etc/grid-security/vomskey.pem
chmod 644 /etc/grid-security/vomscert.pem
chmod 400 /etc/grid-security/vomskey.pem
chown voms:voms /etc/grid-security/voms*.pem

for vo in ${VO_0_NAME} ${VO_1_NAME}; do

  mkdir -p /etc/voms/${vo}
  cp ${ASSETS}/conf/${vo}.conf /etc/voms/${vo}/voms.conf
  echo "pwd" > /etc/voms/${vo}/voms.pass
  chmod 640 /etc/voms/${vo}/voms.pass
  chown ${VOMS_USER}:${VOMS_USER} /etc/voms/${vo}/voms.pass
done


echo "Done."
