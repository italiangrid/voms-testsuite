#!/bin/bash
set -ex
trap "exit 1" TERM

dnf -y config-manager --set-enabled crb
dnf -y install diffutils git gdb procps
dnf -y builddep /voms-src/voms.spec

# prepare a build area
mkdir /build
chown ${VOMS_USER}:${VOMS_USER} /build

echo "Done."