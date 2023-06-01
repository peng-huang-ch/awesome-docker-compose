# 创建存储和日志目录

```sh
mkdir -p data/{pulsar}
```

## 初始化启动

- 启动

```sh
docker-compose up -d
```

## 配置 pulsar manager

```sh
Name: testing
ServiceURL: http://pulsar:8080
BookieURL ServiceUrl: http://pulsar:6650
```

## 参考

- [pulsar-manager docker-compose.yml](https://github.com/apache/pulsar-manager/blob/master/docker/docker-compose.yml)