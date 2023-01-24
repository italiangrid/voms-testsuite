#!/bin/bash
set -ex

# Script from
# https://raw.githubusercontent.com/italiangrid/voms-admin-server/master/docker/voms-admin-server/dev/centos7/setup/setup-voms-user.sh

VOMS_USER=${VOMS_USER:-voms}
VOMS_USER_UID=${VOMS_USER_UID:-1234}
VOMS_USER_HOME=${VOMS_USER_HOME:-/home/${VOMS_USER}}

# Add voms user to the sudoers
echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
adduser --uid ${VOMS_USER_UID} ${VOMS_USER}
usermod -a -G wheel ${VOMS_USER}