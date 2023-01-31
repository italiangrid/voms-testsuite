#!/bin/bash
set -ex

# the igi-test-ca was installed during image building, but mounting
# the /etc/grid-security/certificates volume overwrites the contents
# of that directory
sudo yum -y reinstall igi-test-ca

echo -e "voms-clients version:\n\n$(voms-proxy-init -version)"

mkdir -p /tmp/reports
cd /home/test/voms-testsuite
REPORTS_DIR="/tmp/reports" ./run-testsuite.sh "$@"
