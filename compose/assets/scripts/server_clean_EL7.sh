#!/bin/bash
set -ex
trap "exit 1" TERM

WGET_OPTIONS=${WGET_OPTIONS:-}

TEST_CA_REPO_URL=${TEST_CA_REPO_URL:-https://ci.cloud.cnaf.infn.it/view/repos/job/repo_test_ca/lastSuccessfulBuild/artifact/test-ca.repo}
VOMS_EXTERNALS_REPO_URL=${VOMS_EXTERNALS_REPO_URL:-https://italiangrid.github.io/voms-repo/repofiles/rhel/voms-externals-el7.repo}
VOMS_REPO_URL=${VOMS_REPO_URL:-https://italiangrid.github.io/voms-repo/repofiles/rhel/voms-beta-el7.repo}

LOCAL_HOSTNAME=${VOMS_HOSTNAME:-hostname -f}

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

VO_0_PORT=${VO_0_PORT:-15000}
VO_1_PORT=${VO_1_PORT:-15001}

MAIL_FROM=${MAIL_FROM:-andrea.ceccanti@cnaf.infn.it}
SMTP_HOST=${SMTP_HOST:-mailhog}

SLEEP_TIME=${SLEEP_TIME:-5}

# install igi-test-ca repo
wget ${WGET_OPTIONS} ${TEST_CA_REPO_URL} -O /etc/yum.repos.d/igi-test-ca.repo

# install voms repos
wget ${WGET_OPTIONS} ${VOMS_EXTERNALS_REPO_URL} -O /etc/yum.repos.d/voms-externals-el7.repo
wget ${WGET_OPTIONS} ${VOMS_REPO_URL} -O /etc/yum.repos.d/voms.repo

yum clean all
yum -y install voms-mysql-mp igi-test-ca

# Startup mysql
systemctl start mariadb
sleep ${SLEEP_TIME}
mysqladmin -uroot password pwd

# Setup host certificate
cp /certs/cert.pem /etc/grid-security/hostcert.pem
cp /certs/key.pem /etc/grid-security/hostkey.pem
chmod 644 /etc/grid-security/hostcert.pem
chmod 400 /etc/grid-security/hostkey.pem

# Configure VO 0
voms-configure install --vo ${VO_0_NAME} \
  --core-port ${VO_0_PORT} \
  --hostname ${LOCAL_HOSTNAME} \
  --createdb --deploy-database  \
  --dbusername ${VO_0_NAME} \
  --dbpassword pwd \
  --mail-from ${MAIL_FROM} \
  --smtp-host ${SMTP_HOST} \
  --dbapwd pwd

# Configure VO 1
voms-configure install --vo ${VO_1_NAME} \
  --core-port ${VO_1_PORT} \
  --hostname ${LOCAL_HOSTNAME} \
  --createdb --deploy-database  \
  --dbusername ${VO_1_NAME} \
  --dbpassword pwd \
  --mail-from ${MAIL_FROM} \
  --smtp-host ${SMTP_HOST} \
  --dbapwd pwd

# Configure VOMS container
sed -i -e "s#localhost#${LOCAL_HOSTNAME}#g" /etc/voms-admin/voms-admin-server.properties

# Configure info providers
voms-config-info-providers -s local -e

# Sleep more in bdii init script to avoid issues on docker
sed -i 's/sleep 2/sleep 5/' /etc/init.d/bdii

# Start BDII
service bdii start

# Run fetch-crl
fetch-crl

# Start VOMS-admin
voms-vo-ctl deploy ${VO_0_NAME}
voms-vo-ctl deploy ${VO_1_NAME}
systemctl start voms-admin 
./wait-for-it.sh -h dev.local.io -p 8443 -t 60 --  voms-admin --vo ${VO_0_NAME} list-groups
voms-admin --vo ${VO_1_NAME} list-groups

# Populate VOs
sh populate-vo.sh ${VO_0_NAME}
sh populate-vo.sh ${VO_1_NAME}

# Setup LSC file
mkdir -p /etc/grid-security/vomsdir/${VO_0_NAME}
mkdir -p /etc/grid-security/vomsdir/${VO_1_NAME}

cp /etc/voms-admin/${VO_0_NAME}/lsc /etc/grid-security/vomsdir/${VO_0_NAME}/${LOCAL_HOSTNAME}.lsc
cp /etc/voms-admin/${VO_1_NAME}/lsc /etc/grid-security/vomsdir/${VO_1_NAME}/${LOCAL_HOSTNAME}.lsc

systemctl start voms@${VO_0_NAME}
systemctl start voms@${VO_1_NAME}

./wait-for-it.sh -h dev.local.io -p 15000 -t 60 -- echo "VOMS daemon running for VO ${VO_0_NAME}"
./wait-for-it.sh -h dev.local.io -p 15001 -t 60 -- echo "VOMS daemon running for VO ${VO_1_NAME}"

echo "Done."
