FROM fedora:29

RUN dnf upgrade -y && dnf clean all
RUN dnf install -y redis-5.0.6-1.fc29 hostname && dnf clean all

COPY run.sh /run.sh
COPY redis.conf /etc/redis.conf
COPY redis-sentinel.conf /etc/redis-sentinel.conf

RUN chown redis:redis /run.sh && \
    chown redis:redis /etc/redis.conf && \
    chown redis:redis /etc/redis-sentinel.conf

# Set user to be the redis UID
USER 994

CMD /usr/bin/bash -c "/run.sh ${SENTINEL_HOST} ${SENTINEL_PORT}"
