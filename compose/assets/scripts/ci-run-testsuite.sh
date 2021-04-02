#!/bin/bash
set -ex

sudo yum -y reinstall igi-test-ca
mkdir -p /tmp/reports
cd /home/test/voms-testsuite
REPORTS_DIR="/tmp/reports" ./run-testsuite.sh
