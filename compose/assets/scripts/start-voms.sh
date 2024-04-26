#!/bin/bash
set -ex
trap "exit 1" TERM

VOMS_HOST=${VOMS_HOST:-voms.test.example}

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

ASSETS="/voms-testsuite/compose/assets"

source /etc/sysconfig/voms

su voms -s /bin/bash -c "voms --conf /etc/voms/${VO_0_NAME}/voms.conf"
su voms -s /bin/bash -c "voms --conf /etc/voms/${VO_1_NAME}/voms.conf"

${ASSETS}/scripts/wait-for-it.sh -h ${VOMS_HOST} -p 15000 -t 10 -- echo "VOMS daemon running for VO ${VO_0_NAME}"
${ASSETS}/scripts/wait-for-it.sh -h ${VOMS_HOST} -p 15001 -t 10 -- echo "VOMS daemon running for VO ${VO_1_NAME}"
