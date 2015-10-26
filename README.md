# docker-redis

[![Build Status](https://travis-ci.org/UKHomeOffice/docker-redis.svg?branch=master)](https://travis-ci.org/UKHomeOffice/docker-redis)

Docker image for redis. This image is designed to be used with kubernetes, it
may work outside kubernetes as well.

It is highly recommended to read through [redis sentinel
documentation](http://redis.io/topics/sentinel).

## Launching it in kubernetes

First of all create a single replica pod of redis and redis-sentinel. Both
containers will notice that `${REDIS_SENTINEL_SERVICE_HOST}` and
`${REDIS_SENTINEL_SERVICE_PORT}` are empty and assume that this is an initial
bootstrap of redis. Redis sentinel will connect to the master at `$(hostname
-i)` and start monitoring it.

```
kubectl create -f kube/redis-controller.yaml
```

Then you need to create redis sentinel service, which will become your redis
sentinel endpoint for the following redis pods.

```
kubectl create -f kube/redis-sentinel-service.yaml
```

Once the service is up and running, you can check whether it is working
properly. Run the following command in some temporary container.

```
redis-cli -h ${REDIS_SENTINEL_SERVICE_HOST} -p 26379 INFO
```

Next, we can start scaling our redis out. It is recommended to add redis and
redis-sentinel replicas one by one.

```
kubectl scale rc redis --replicas=2
```

Wait a minute and check on the sentinel service `redis-cli -h
${REDIS_SENTINEL_SERVICE_HOST} -p 26379 INFO`, then scale to `--replicas=3`.

