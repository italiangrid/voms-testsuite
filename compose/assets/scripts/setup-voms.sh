#!/bin/bash
set -ex
trap "exit 1" TERM

VOMS_HOST=${VOMS_HOST:-voms.test.example}
VOMS_USER=${VOMS_USER:-voms}
VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

echo "VOMS version: $(rpm -q voms)"

dnf -y config-manager --set-enabled crb
dnf -y install diffutils git gdb procps util-linux-user
dnf -y builddep /voms-src/voms.spec

chsh ${VOMS_USER} -s /bin/bash
echo ${VOMS_USER} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${VOMS_USER}
chmod 0440 /etc/sudoers.d/${VOMS_USER}

# Setup host certificate
cp /hostcerts/voms_test_example.cert.pem /etc/grid-security/vomscert.pem
cp /hostcerts/voms_test_example.key.pem /etc/grid-security/vomskey.pem
chmod 644 /etc/grid-security/vomscert.pem
chmod 400 /etc/grid-security/vomskey.pem
cp /hostcerts/voms_test_example_ec.cert.pem /etc/grid-security/vomscert_ec.pem
cp /hostcerts/voms_test_example_ec.key.pem /etc/grid-security/vomskey_ec.pem
chmod 644 /etc/grid-security/vomscert_ec.pem
chmod 400 /etc/grid-security/vomskey_ec.pem
chown voms:voms /etc/grid-security/voms*.pem

# Setup VOMS pwd file
echo "pwd" > /etc/voms/${VO_0_NAME}/voms.pass
echo "pwd" > /etc/voms/${VO_1_NAME}/voms.pass
chmod 640 /etc/voms/${VO_0_NAME}/voms.pass
chmod 640 /etc/voms/${VO_1_NAME}/voms.pass
chown ${VOMS_USER}:${VOMS_USER} /etc/voms/${VO_0_NAME}/voms.pass
chown ${VOMS_USER}:${VOMS_USER} /etc/voms/${VO_1_NAME}/voms.pass

chown ${VOMS_USER}:${VOMS_USER} /var/log/voms

# prepare a build area
mkdir /build
chown ${VOMS_USER}:${VOMS_USER} /build

echo "Done."
