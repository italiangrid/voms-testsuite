#!/bin/bash
set -ex
trap "exit 1" TERM

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

VOMS_USER=${VOMS_USER:-voms}

SCRIPTS_PREFIX=${SCRIPTS_PREFIX:-/scripts}

yum clean all
yum -y install voms-mysql-plugin voms-server

# Setup host certificate
cp /hostcerts/star_test_example.cert.pem /etc/grid-security/vomscert.pem
cp /hostcerts/star_test_example.key.pem /etc/grid-security/vomskey.pem
chmod 644 /etc/grid-security/vomscert.pem
chmod 400 /etc/grid-security/vomskey.pem
chown voms:voms /etc/grid-security/voms*.pem

# Setup VOMS pwd file
echo "pwd" > /etc/voms/${VO_0_NAME}/voms.pass
echo "pwd" > /etc/voms/${VO_1_NAME}/voms.pass
chmod 640 /etc/voms/${VO_0_NAME}/voms.pass
chmod 640 /etc/voms/${VO_1_NAME}/voms.pass
chown voms:voms /etc/voms/${VO_0_NAME}/voms.pass
chown voms:voms /etc/voms/${VO_1_NAME}/voms.pass

# Add voms user to the sudoers
echo ${VOMS_USER} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${VOMS_USER}
chmod 0440 /etc/sudoers.d/${VOMS_USER}

echo -e "VOMS version:\n\n$(rpm -q voms)"

source /etc/sysconfig/voms

su voms -s /bin/bash -c "voms --conf /etc/voms/${VO_0_NAME}/voms.conf"
su voms -s /bin/bash -c "voms --conf /etc/voms/${VO_1_NAME}/voms.conf"

${SCRIPTS_PREFIX}/wait-for-it.sh -h voms.test.example -p 15000 -t 10 -- echo "VOMS daemon running for VO ${VO_0_NAME}"
${SCRIPTS_PREFIX}/wait-for-it.sh -h voms.test.example -p 15001 -t 10 -- echo "VOMS daemon running for VO ${VO_1_NAME}"

echo "Done."