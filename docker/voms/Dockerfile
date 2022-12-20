ARG RHEL_VERSION=7
FROM centos:$RHEL_VERSION

# Allow customization of test user ID and name
ARG TEST_USER=test
ARG TEST_USER_UID=501

ARG UMD_RELEASE_PACKAGE_URL=http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm

ARG VOMS_REPO=stable

# Allow customization of VOMS_REPO
ENV VOMS_URL_REPO=https://italiangrid.github.io/voms-repo/repofiles/rhel/voms-${VOMS_REPO}-el$RHEL_VERSION.repo

RUN echo "include_only=.garr.it,.cern.ch" >> /etc/yum/pluginconf.d/fastestmirror.conf && \
  yum -y install hostname which wget tar sudo file less epel-release ${UMD_RELEASE_PACKAGE_URL} && \
  wget ${VOMS_URL_REPO} -o /etc/yum.repos.d/voms-${VOMS_REPO}-el$RHEL_VERSION.repo && \
  yum -y update && \
  yum clean all && \
  rm -rf /var/cache/yum && \
  adduser --uid ${TEST_USER_UID} ${TEST_USER} && \
  echo ${TEST_USER} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${TEST_USER} && \
  chmod 0440 /etc/sudoers.d/${TEST_USER} && \
  (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do \
  [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
  rm -f /lib/systemd/system/multi-user.target.wants/*; \
  rm -f /etc/systemd/system/*.wants/*; \
  rm -f /lib/systemd/system/local-fs.target.wants/*; \
  rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
  rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
  rm -f /lib/systemd/system/basic.target.wants/*; \
  rm -f /lib/systemd/system/anaconda.target.wants/*;

ENV container=docker

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
