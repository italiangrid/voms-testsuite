FROM almalinux:9

COPY ./x509 /

RUN dnf install -y epel-release && \
      dnf -y update && \
      dnf -y install git voms-clients-cpp faketime && \
      git clone https://baltig.infn.it/mw-devel/helper-scripts.git

ENV PATH=/helper-scripts/x509-scripts/scripts:$PATH

RUN  sh setup-trust.sh