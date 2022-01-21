FROM rockylinux:8

RUN dnf install -y git dnf-plugins-core epel-release && \
    dnf config-manager --set-enabled powertools && dnf -y update

COPY ceph.repo /etc/yum.repos.d/ceph.repo 

RUN dnf install -y ceph ceph-common ceph-radosgw

RUN dnf install -y procps

ADD ceph-container /opt/ceph-container

ENV CEPH_DAEMON=demo
ENV CEPH_PUBLIC_NETWORK=0.0.0.0/0
ENV MON_IP=127.0.0.1

COPY my-entrypoint.sh /

ENTRYPOINT ["/my-entrypoint.sh"]
