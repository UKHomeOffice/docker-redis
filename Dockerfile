FROM fedora:37

RUN dnf upgrade -y && dnf clean all
RUN dnf install -y redis-7.0.9-1.fc37 hostname && dnf clean all

COPY run.sh /run.sh
COPY redis.conf /etc/redis.conf
COPY redis-sentinel.conf /etc/redis-sentinel.conf

# Create the /var/lib/redis/ directory, set ownership, and permissions
RUN mkdir -p /var/lib/redis && \
    chown redis:redis /var/lib/redis && \
    chmod 700 /var/lib/redis && \
    chown redis:redis /run.sh && \
    chown redis:redis /etc/redis.conf && \
    chown redis:redis /etc/redis-sentinel.conf

# Set user to be the redis UID
USER 994

CMD /usr/bin/bash -c "/run.sh ${SENTINEL_HOST} ${SENTINEL_PORT}"