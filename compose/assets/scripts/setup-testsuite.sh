#!/bin/bash
set -ex
trap "exit 1" TERM

VOMS_HOST=${VOMS_HOST:-voms.test.example}

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

ASSETS="/voms-testsuite/compose/assets"

mkdir -p /etc/vomses
cp ${ASSETS}/vomses/test.vo.vomses /etc/vomses
sed -e "s/voms.test.example/${VOMS_HOST}/" ${ASSETS}/vomses/voms.test.example.vomses > /etc/vomses/voms.test.example.vomses

mkdir -p /etc/grid-security/vomsdir
cp -r ${ASSETS}/vomsdir/test.vo /etc/grid-security/vomsdir
cp -r ${ASSETS}/vomsdir/test.vo.2 /etc/grid-security/vomsdir
for vo in ${VO_0_NAME} ${VO_1_NAME}; do
  cp -r ${ASSETS}/vomsdir/${vo} /etc/grid-security/vomsdir
  ln -sf voms.test.example.lsc /etc/grid-security/vomsdir/${vo}/voms-7-stable.test.example.lsc
  ln -sf voms.test.example.lsc /etc/grid-security/vomsdir/${vo}/voms-7-beta.test.example.lsc
  ln -sf voms.test.example.lsc /etc/grid-security/vomsdir/${vo}/voms-9-beta.test.example.lsc
done
