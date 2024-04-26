#!/bin/bash
set -ex

WGET_OPTIONS=${WGET_OPTIONS:-}
TEST_CA_REPO_URL=${TEST_CA_REPO_URL:-https://jenkins-ci.cr.cnaf.infn.it:8443/job/igi-test-ca-repo/job/master/lastSuccessfulBuild/artifact/test-ca.repo}

if ! rpm -q --quiet igi-test-ca; then
  wget ${WGET_OPTIONS} ${TEST_CA_REPO_URL} -O /etc/yum.repos.d/igi-test-ca.repo
  yum -y install igi-test-ca
fi
