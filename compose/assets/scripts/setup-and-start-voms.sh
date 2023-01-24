#!/bin/bash
set -ex
trap "exit 1" TERM

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

SCRIPT_PREFIX=${SCRIPTS_PREFIX:-/scripts}

# install igi-test-ca repo
wget ${WGET_OPTIONS} ${TEST_CA_REPO_URL} -O /etc/yum.repos.d/igi-test-ca.repo

yum clean all
yum -y install voms-mysql-mp igi-test-ca

${SCRIPTS_PREFIX}/setup-voms-user.sh

source /etc/sysconfig/voms

su voms -s /bin/bash -c "voms --conf /etc/voms/${VO_0_NAME}/voms.conf"
su voms -s /bin/bash -c "voms --conf /etc/voms/${VO_1_NAME}/voms.conf"

${SCRIPTS_PREFIX}/wait-for-it.sh -h dev.local.io -p 15000 -t 60 -- echo "VOMS daemon running for VO ${VO_0_NAME}"
${SCRIPTS_PREFIX}/wait-for-it.sh -h dev.local.io -p 15001 -t 60 -- echo "VOMS daemon running for VO ${VO_1_NAME}"

echo "Done."