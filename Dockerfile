FROM fedora:23

RUN dnf upgrade -y && dnf clean all
RUN dnf install -y redis-3.0.4-1.fc23 hostname && dnf clean all

COPY run.sh /run.sh
COPY redis.conf /etc/redis.conf
COPY redis-sentinel.conf /etc/redis-sentinel.conf

CMD /usr/bin/bash -c "/run.sh ${SENTINEL_HOST} ${SENTINEL_PORT}"
