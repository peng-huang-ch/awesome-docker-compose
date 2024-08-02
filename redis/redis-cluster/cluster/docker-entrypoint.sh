#!/bin/sh
set -e

echo ${CLUSTER_CONF_PATH}

# create /etc/redis/cluster.conf
if [ ! -e ${CLUSTER_CONF_PATH} ]; then
    echo ${CLUSTER_CONF_PATH}
    envsubst < /etc/redis/cluster.conf.sample > ${CLUSTER_CONF_PATH}
    chown redis:redis /etc/redis/cluster.conf
fi

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'redis-server' -a "$(id -u)" = '0' ]; then
	chown -R redis .
	exec su-exec redis "$0" "$@"
fi

exec "$@"
