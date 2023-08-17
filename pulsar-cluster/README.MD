# 创建存储和日志目录

```sh
mkdir -p data/{bookkeeper,zookeeper}
```

## 初始化启动

- 启动

```sh
docker-compose up -d
```

## 配置 pulsar manager

```sh
Name: cluster-a
ServiceURL: http://broker:8080
BookieURL ServiceUrl: http://broker:6650
```

## 参考

- [Run a Pulsar cluster locally with Docker Compose](https://pulsar.apache.org/docs/3.0.x/getting-started-docker-compose/)
