#!/bin/bash
set -ex

mkdir -p /tmp/reports
cd /home/test/voms-testsuite
REPORTS_DIR="/tmp/reports" ./run-testsuite.sh
