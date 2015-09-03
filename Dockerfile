FROM fedora:22

RUN dnf upgrade -y && dnf clean all
RUN dnf --releasever 23 install -y redis-3.0.3-1.fc23.x86_64 hostname && dnf clean all

COPY run.sh /run.sh
COPY redis.conf /etc/redis.conf
COPY redis-sentinel.conf /etc/redis-sentinel.conf

CMD /usr/bin/bash -c "/run.sh ${SENTINEL_HOST} ${SENTINEL_PORT}"
