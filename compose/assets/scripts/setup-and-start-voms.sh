#!/bin/bash
set -ex
trap "exit 1" TERM

WGET_OPTIONS=${WGET_OPTIONS:-}

TEST_CA_REPO_URL=${TEST_CA_REPO_URL:-https://ci.cloud.cnaf.infn.it/view/repos/job/repo_test_ca/lastSuccessfulBuild/artifact/test-ca.repo}

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

VOMS_USER=${VOMS_USER:-voms}

SCRIPTS_PREFIX=${SCRIPTS_PREFIX:-/scripts}

# install igi-test-ca repo
wget ${WGET_OPTIONS} ${TEST_CA_REPO_URL} -O /etc/yum.repos.d/igi-test-ca.repo

yum clean all
yum -y install voms-mysql-plugin voms-server igi-test-ca

# Setup host certificate
cp /usr/share/igi-test-ca/star.test.example.cert.pem /etc/grid-security/vomscert.pem
cp /usr/share/igi-test-ca/star.test.example.key.pem /etc/grid-security/vomskey.pem
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

source /etc/sysconfig/voms

su voms -s /bin/bash -c "voms --conf /etc/voms/${VO_0_NAME}/voms.conf"
su voms -s /bin/bash -c "voms --conf /etc/voms/${VO_1_NAME}/voms.conf"

${SCRIPTS_PREFIX}/wait-for-it.sh -h voms.test.example -p 15000 -t 10 -- echo "VOMS daemon running for VO ${VO_0_NAME}"
${SCRIPTS_PREFIX}/wait-for-it.sh -h voms.test.example -p 15001 -t 10 -- echo "VOMS daemon running for VO ${VO_1_NAME}"

echo "Done."