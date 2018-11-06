### 创建文件夹

```sh
mkdir -p data/{zoo1,zoo2,zoo3}
mkdir -p logs/{zoo1,zoo2,zoo3}
```

### 连接集群

```sh
docker run -it --rm --link zoo1:zk1 --link zoo2:zk2 --link zoo3:zk3  --net zookeeper_default zookeeper zkCli.sh -server zk1:2181, zk2:2181, zk3:2181
```