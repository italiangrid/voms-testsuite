#!/bin/bash
set -ex

MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD:-pwd}

SCRIPTS_PREFIX=${SCRIPTS_PREFIX:-/home/mysql}
VO_NAME_PREFIX=${VOMS_VO_NAME_PREFIX:-"voms_vo"}
VO_COUNT=${VOMS_VO_COUNT:-1}

load_db_dump(){

  VO_NAME=${VO_NAME_PREFIX}_$1
  dump_file=dump-${VO_NAME}.sql
  if [ -f ${SCRIPTS_PREFIX}/${dump_file} ]; then
    echo "Loading dump file ${SCRIPTS_PREFIX}/${dump_file} for VO ${VO_NAME}"
    mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "create database ${VO_NAME}"
    cat ${SCRIPTS_PREFIX}/${dump_file} | mysql -u root -p${MYSQL_ROOT_PASSWORD} ${VO_NAME}
  else
    echo "${dump_file} not found"
  fi

}

/scripts/wait-for-it.sh -h db -p 3306 -t 5 -- echo "db is up and running"

for i in $(seq 0 ${VO_COUNT}); do
  load_db_dump $i
done

VO_NAME=indigo_dc
dump_file=dump-${VO_NAME}.sql
echo "Loading dump file ${SCRIPTS_PREFIX}/${dump_file} for VO indigo-dc"
mysql -u root -p${MYSQL_ROOT_PASSWORD} -e "create database ${VO_NAME}"
cat ${SCRIPTS_PREFIX}/${dump_file} | mysql -u root -p${MYSQL_ROOT_PASSWORD} ${VO_NAME}

mysql -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO 'user'@'%'"

echo "VOMS db has been populated !"
echo "Exit $?"
