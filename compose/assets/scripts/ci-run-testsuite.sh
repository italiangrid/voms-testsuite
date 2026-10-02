#!/bin/bash
set +ex

voms-proxy-init -version

mkdir -p /tmp/reports
cd /home/test/voms-testsuite
REPORTS_DIR="/tmp/reports" ./run-testsuite.sh "$@"
