#!/bin/bash
set -ex

VO_NAME_PREFIX=${VOMS_VO_NAME_PREFIX:-"vo"}
VO_COUNT=${VOMS_VO_COUNT:-1}
VOMS_MYSQL_HOST=${VOMS_MYSQL_HOST:-db}
VOMS_MAIL_FROM=${VOMS_MAIL_FROM:-francesco.giacomini@cnaf.infn.it}
VOMS_SMTP_HOST=${VOMS_SMTP_HOST:-mailhog}
VOMS_HOSTNAME=${VOMS_HOSTNAME:-hostname -f}
BASE_CORE_PORT=${VOMS_BASE_CORE_PORT:-15000}

configure_vo(){

  VO_NAME=${VO_NAME_PREFIX}.$1
  voms-configure install \
    --vo ${VO_NAME} \
    --dbtype mysql \
    --deploy-database \
    --dbusername user \
    --dbpassword pwd \
    --dbhost ${VOMS_MYSQL_HOST} \
    --mail-from ${VOMS_MAIL_FROM} \
    --smtp-host ${VOMS_SMTP_HOST} \
    --membership-check-period 60 \
    --hostname ${VOMS_HOSTNAME} \
    --core-port $((${BASE_CORE_PORT}+$1)) \
    ${CONFIGURE_VO_OPTIONS}
}

for i in $(seq 0 ${VO_COUNT}); do
  configure_vo $i
done

if [[ -f "/etc/voms-admin/voms-admin-server.properties" ]]; then
  sed -i -e "s#localhost#${VOMS_HOSTNAME}#g" \
    /etc/voms-admin/voms-admin-server.properties
fi