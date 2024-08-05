FROM docker.elastic.co/logstash/logstash:6.3.2

# LABEL maintainer="hhap"

USER root
WORKDIR /var/opt

ADD http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz .
RUN tar -xzvf GeoLite2-City.tar.gz && \
  mv GeoLite2-City*/ GeoLite2-City/ && \
  chmod -R 664 /var/opt/GeoLite2-City/* && \
  chown -R logstash:logstash /var/opt/GeoLite2-City

WORKDIR /usr/share/logstash/bin/

USER logstash
EXPOSE 12201/udp

CMD ["logstash", "-f", "/etc/logstash/conf.d/logstash.conf", "--config.reload.automatic"]