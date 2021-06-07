FROM centos:7

ARG TEST_USER=test
ARG TEST_USER_UID=501

ENV TEST_USER $TEST_USER
ENV TEST_USER_UID $TEST_USER_UID

COPY assets/scripts/*.sh /tmp/scripts/

RUN    yum install -y wget epel-release \
    && wget https://ci.cloud.cnaf.infn.it/view/repos/job/repo_test_ca/lastSuccessfulBuild/artifact/test-ca.repo -O /etc/yum.repos.d/test-ca.repo \
    && yum -y update \
    && yum -y install hostname tar gcc openssl-devel sudo file make which telnet nc \
       igi-test-ca voms-clients-java gfal2-util gfal2-all gfal2-python davix jq \
       python36 python36-devel python36-setuptools \
    && rm -rf /var/cache/yum \
    && adduser --uid ${TEST_USER_UID} ${TEST_USER} \
    && echo ${TEST_USER} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${TEST_USER} \
    && chmod 0440 /etc/sudoers.d/${TEST_USER} \
    && mkdir /home/${TEST_USER}/.config /home/${TEST_USER}/.globus \
    && cp /usr/share/igi-test-ca/test0.p12 /home/${TEST_USER}/.globus/usercred.p12 \
    && chmod 600 /home/${TEST_USER}/.globus/usercred.p12 \
    && chown -R ${TEST_USER}:${TEST_USER} /home/${TEST_USER} \
    && bash /tmp/scripts/provide_curl.sh \
    && bash /tmp/scripts/provide_robotframework.sh \
    && rm -rf /tmp/scripts

USER ${TEST_USER}
WORKDIR /home/${TEST_USER}
