# Pulsar standalone

The standalone mode runs all components inside a single Java Virtual Machine (JVM) process.

## Create data and log dir

```sh
mkdir -p data/{pulsar}
```

## Start

```sh
docker-compose up -d
```

### Pulsar manager

```sh
Name: testing
ServiceURL: http://pulsar:8080
BookieURL ServiceUrl: http://pulsar:6650
```

## Reference

- [pulsar-manager docker-compose.yml](https://github.com/apache/pulsar-manager/blob/master/docker/docker-compose.yml)
