#!/bin/bash
set -ex
trap "exit 1" TERM

VOMS_EXTERNALS_REPO_URL=${VOMS_EXTERNALS_REPO_URL:-https://italiangrid.github.io/voms-repo/repofiles/rhel/voms-externals-el7.repo}
VOMS_REPO_URL=${VOMS_REPO_URL:-https://italiangrid.github.io/voms-repo/repofiles/rhel/voms-beta-el7.repo}

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

VO_0_PORT=${VO_0_PORT:-15000}
VO_1_PORT=${VO_1_PORT:-15001}


yum clean all
yum -y install voms-mysql-mp

# Sleep more in bdii init script to avoid issues on docker
sed -i 's/sleep 2/sleep 5/' /etc/init.d/bdii

# Start BDII
service bdii start

systemctl start voms@${VO_0_NAME}
systemctl start voms@${VO_1_NAME}

./wait-for-it.sh -h dev.local.io -p ${VO_0_PORT} -t 60 -- echo "VOMS daemon running for VO ${VO_0_NAME}"
./wait-for-it.sh -h dev.local.io -p ${VO_1_PORT} -t 60 -- echo "VOMS daemon running for VO ${VO_1_NAME}"

echo "Done."