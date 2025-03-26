#!/bin/bash
set -ex

echo -e "voms-clients version:\n\n$(voms-proxy-init -version)"

mkdir -p /tmp/reports
cd /home/test/voms-testsuite
REPORTS_DIR="/tmp/reports" ./run-testsuite.sh "$@"
