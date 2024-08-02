# Pulsar cluster

## Create data and log dir

```sh
mkdir -p data/{bookkeeper,zookeeper}
# this step might not be necessary on other than Linux platforms
chown -R 10000 data
```

## How to use this Compose file

```sh
docker-compose up -d
```

## Pulsar Manager

```sh
Name: cluster-a
ServiceURL: http://broker:8080
BookieURL ServiceUrl: http://broker:6650
```

## 参考

- [Run a Pulsar cluster locally with Docker Compose](https://pulsar.apache.org/docs/3.0.x/getting-started-docker-compose/)
