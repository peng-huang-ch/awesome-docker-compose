FROM redis:5.0.5-alpine

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
RUN apk add --no-cache gettext

ENV CLUSTER_CONF_PATH=/etc/redis/cluster.conf

ADD cluster.conf.sample /etc/redis/cluster.conf.sample

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379

CMD ["redis-server"]
