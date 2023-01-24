#!/bin/bash
set -ex
trap "exit 1" TERM

WGET_OPTIONS=${WGET_OPTIONS:-}

TEST_CA_REPO_URL=${TEST_CA_REPO_URL:-https://ci.cloud.cnaf.infn.it/view/repos/job/repo_test_ca/lastSuccessfulBuild/artifact/test-ca.repo}

LOCAL_HOSTNAME=${VOMS_HOSTNAME:-hostname -f}

VO_0_NAME=${VO_0_NAME:-vo.0}
VO_1_NAME=${VO_1_NAME:-vo.1}

VO_0_PORT=${VO_0_PORT:-15000}
VO_1_PORT=${VO_1_PORT:-15001}

SLEEP_TIME=${SLEEP_TIME:-5}

SCRIPT_PREFIX=${SCRIPTS_PREFIX:-/scripts}
CONFIGURE_VO_OPTIONS={CONFIGURE_VO_OPTIONS:-}

# install igi-test-ca repo
wget ${WGET_OPTIONS} ${TEST_CA_REPO_URL} -O /etc/yum.repos.d/igi-test-ca.repo

yum clean all
yum install -y hostname epel-release openssl mysql voms-admin-server voms-admin-client igi-test-ca

# Check that mysql is up and running
VOMS_MYSQL_HOST=${VOMS_MYSQL_HOST:-db}
VOMS_MYSQL_PORT=${VOMS_MYSQL_PORT:-3306}

mysql_host=${VOMS_MYSQL_HOST}
mysql_port=${VOMS_MYSQL_PORT}

echo -n "waiting for TCP connection to $mysql_host:$mysql_port..."

while ! ${SCRIPTS_PREFIX}/wait-for-it.sh -h $mysql_host -p $mysql_port -t 1 2>/dev/null
do
  echo -n .
  sleep 1
done

echo 'Database server is up.'

${SCRIPTS_PREFIX}/setup-voms-user.sh

# Setup host certificate
cp /certs/cert.pem /etc/grid-security/hostcert.pem
cp /certs/key.pem /etc/grid-security/hostkey.pem
chmod 644 /etc/grid-security/hostcert.pem
chmod 400 /etc/grid-security/hostkey.pem
chown voms:voms /etc/grid-security/host*.pem

# Inspired by
# https://raw.githubusercontent.com/italiangrid/voms-admin-server/master/docker/voms-admin-server/dev/centos7/setup/configure-vos.sh

CONFIGURE_VO_OPTIONS ${SCRIPTS_PREFIX}/configure-vos.sh

# Run fetch-crl
fetch-crl

voms-vo-ctl deploy ${VO_0_NAME}
voms-vo-ctl deploy ${VO_1_NAME}

# Start service
VOMS_JAR=${VOMS_JAR:-/usr/share/java/voms-container.jar}
VOMS_MAIN_CLASS=${VOMS_MAIN_CLASS:-org.italiangrid.voms.container.Container}
ORACLE_LIBRARY_PATH=${ORACLE_LIBRARY_PATH:-/usr/lib64/oracle/11.2.0.3.0/client/lib64}
OJDBC_JAR=${OJDBC_JAR:-${ORACLE_LIBRARY_PATH}/ojdbc6.jar}

cd /var/lib/voms-admin
source /etc/sysconfig/voms-admin
su voms -s /bin/bash -c "java $VOMS_JAVA_OPTS -cp $VOMS_JAR:$OJDBC_JAR $VOMS_MAIN_CLASS >/var/log/voms-admin/voms-admin.out 2>/var/log/voms-admin/voms-admin.err

echo "Done."