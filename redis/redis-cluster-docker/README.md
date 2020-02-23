# 说明

   本项目只是用于演示，若部署到服务器，请使用[Grokzen](https://github.com/Grokzen/docker-redis-cluster)

## 准备

创建目录

`mkdir -p data/node-{80,81,82,83,84,85}/{data,logs}`

启动

`docker-compose up -d`

## 集群信息查看

Info 查看单节点信息

```log
127.0.0.1:6380> info
# Server
redis_version:5.0.5
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:4d072dc1c62d5672
redis_mode:cluster
```

Cluster info 查看集群信息

```log
127.0.0.1:6380> cluster info
cluster_state:fail
cluster_slots_assigned:0
cluster_slots_ok:0
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:1
cluster_size:0
cluster_current_epoch:0
cluster_my_epoch:0
cluster_stats_messages_sent:0
cluster_stats_messages_received:0
```

Cluster nodes 查看集群节点信息

```log
127.0.0.1:6380> cluster nodes
988e22fc70bae1151012fbcc5886658753b6cbe2 :6380@16380 myself,master - 0 0 0 connected
```

## 集群快速搭建

通过 `docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container-name` 可以查看各个节点在容器内网的ip，
下面的命令须使用ip而非容器名称, 宿主机ip未尝试

```sh
docker exec -it node-80 redis-cli -p 6380 --cluster create {node-80 ip}:6380  {node-81 ip}:6381  {node-82 ip}:6382  {node-83 ip}:6383  {node-84 ip}:6384  {node-85 ip}:6385 --cluster-replicas 1
```

### 实际执行命令和结果

```sh
docker exec -it node-80 redis-cli -p 6380 --cluster create 172.31.0.4:6380  172.31.0.3:6381  172.31.0.2:6382  172.31.0.7:6383  172.31.0.6:6384 172.31.0.5:6385 --cluster-replicas 1
>>> Performing hash slots allocation on 6 nodes...
Master[0] -> Slots 0 - 5460
Master[1] -> Slots 5461 - 10922
Master[2] -> Slots 10923 - 16383
Adding replica 172.31.0.6:6384 to 172.31.0.4:6380
Adding replica 172.31.0.5:6385 to 172.31.0.3:6381
Adding replica 172.31.0.7:6383 to 172.31.0.2:6382
M: f7e32d6f129df7c76c9df943a5913ce19f4ebe2c 172.31.0.4:6380
   slots:[0-5460] (5461 slots) master
M: 0baaae4639bdddb391ceb015c1a5cca4224233ad 172.31.0.3:6381
   slots:[5461-10922] (5462 slots) master
M: e07ef3567ec2c6397d30e206b4025336ad6b8e43 172.31.0.2:6382
   slots:[10923-16383] (5461 slots) master
S: a1520b7c7a2d694b8db9c9289a8882c9ebd2901a 172.31.0.7:6383
   replicates e07ef3567ec2c6397d30e206b4025336ad6b8e43
S: e1e1a81ac9991857f83695ca5246074eb625db79 172.31.0.6:6384
   replicates f7e32d6f129df7c76c9df943a5913ce19f4ebe2c
S: 6d92a077f6e1ea55741b6cd103e5cad7b617ea56 172.31.0.5:6385
   replicates 0baaae4639bdddb391ceb015c1a5cca4224233ad
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
>>> Sending CLUSTER MEET messages to join the cluster
Waiting for the cluster to join
........
>>> Performing Cluster Check (using node 172.31.0.4:6380)
M: f7e32d6f129df7c76c9df943a5913ce19f4ebe2c 172.31.0.4:6380
   slots:[0-5460] (5461 slots) master
   1 additional replica(s)
M: 0baaae4639bdddb391ceb015c1a5cca4224233ad 172.31.0.3:6381
   slots:[5461-10922] (5462 slots) master
   1 additional replica(s)
S: e1e1a81ac9991857f83695ca5246074eb625db79 172.31.0.6:6384
   slots: (0 slots) slave
   replicates f7e32d6f129df7c76c9df943a5913ce19f4ebe2c
M: e07ef3567ec2c6397d30e206b4025336ad6b8e43 172.31.0.2:6382
   slots:[10923-16383] (5461 slots) master
   1 additional replica(s)
S: a1520b7c7a2d694b8db9c9289a8882c9ebd2901a 172.31.0.7:6383
   slots: (0 slots) slave
   replicates e07ef3567ec2c6397d30e206b4025336ad6b8e43
S: 6d92a077f6e1ea55741b6cd103e5cad7b617ea56 172.31.0.5:6385
   slots: (0 slots) slave
   replicates 0baaae4639bdddb391ceb015c1a5cca4224233ad
[OK] All nodes agree about slots configuration.
>>> Check for open slots...
>>> Check slots coverage...
[OK] All 16384 slots covered.
```

### 测试结果

```sh
docker exec -it node-80 redis-cli -p 6380 set xxx 1
OK
————————————————

docker exec -it node-80 redis-cli -p 6380 get xxx
"1"

```

## 手动创建

### 节点握手

   节点握手是指一批运行在集群模式下的节点通过Gossip协议彼此通信，达到感知对方的过

>命令 `cluster meet {ip} {port}`  
>加入节点到集群，此时集群还是未启动成功，因为`slot`未完全分配

```sh
docker exec -it node-80 redis-cli -p 6380
127.0.0.1:6380> cluster nodes
988e22fc70bae1151012fbcc5886658753b6cbe2 :6380@16380 myself,master - 0 0 0 connected
127.0.0.1:6380> cluster meet 192.168.32.6 6381
OK
127.0.0.1:6380> cluster meet 192.168.32.7 6382
OK
127.0.0.1:6380> cluster nodes
ba6eaf31cab4b080a0ef26f022565d49f554cfce 192.168.32.7:6382@16382 master - 0 1582455714558 0 connected
183a22026d486f19e05970a4642ce66c4733a03f 192.168.32.6:6381@16381 master - 0 1582455713000 1 connected
988e22fc70bae1151012fbcc5886658753b6cbe2 192.168.32.5:6380@16380 myself,master - 0 1582455714000 2 connected
```

#### 未分配槽集群信息

> 此时集群还是未启动成功，因为`slot`未完全分配

```sh
127.0.0.1:6380> cluster info
cluster_state:fail
cluster_slots_assigned:0
cluster_slots_ok:0
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:3
cluster_size:0
cluster_current_epoch:2
cluster_my_epoch:2
cluster_stats_messages_ping_sent:209
cluster_stats_messages_pong_sent:211
cluster_stats_messages_meet_sent:2
cluster_stats_messages_sent:422
cluster_stats_messages_ping_received:211
cluster_stats_messages_pong_received:211
cluster_stats_messages_received:422
```

### 分配槽

>slots个数：16384  
>cluster addslots {0..5461}

```sh
docker exec -it node-80 redis-cli -p 6380 cluster addslots {0..6000}
OK
docker exec -it node-81 redis-cli -p 6381 cluster addslots {6001..9000}
OK
docker exec -it node-82 redis-cli -p 6382 cluster addslots {9001..16383}
OK
```

#### 分配槽集群信息

   cluster_slots_assigned 为 `16384`，此时集群还是启动成功

```sh
127.0.0.1:6380> cluster info
cluster_state:ok
cluster_slots_assigned:16384
cluster_slots_ok:16384
cluster_slots_pfail:0
cluster_slots_fail:0
cluster_known_nodes:3
cluster_size:3
cluster_current_epoch:2
cluster_my_epoch:2
cluster_stats_messages_ping_sent:4995
cluster_stats_messages_pong_sent:5409
cluster_stats_messages_meet_sent:2
cluster_stats_messages_sent:10406
cluster_stats_messages_ping_received:5409
cluster_stats_messages_pong_received:4997
cluster_stats_messages_received:10406
```

### 分配从节点

#### 添加节点

```sh
127.0.0.1:6380> cluster meet 192.168.32.3 6383
OK
127.0.0.1:6380> cluster meet 192.168.32.4 6384
OK
127.0.0.1:6380> cluster meet 192.168.32.2 6385
OK
```

#### 节点信息

```sh
127.0.0.1:6380> cluster nodes
ba6eaf31cab4b080a0ef26f022565d49f554cfce 192.168.32.7:6382@16382 master - 0 1582461537000 5 connected 9001-16383
d6b6dfc2af537d755558d7439fff27f18105ec61 192.168.32.2:6385@16385 master - 0 1582461536478 0 connected
988e22fc70bae1151012fbcc5886658753b6cbe2 192.168.32.5:6380@16380 myself,master - 0 1582461538000 2 connected 0-6000
183a22026d486f19e05970a4642ce66c4733a03f 192.168.32.6:6381@16381 master - 0 1582461537510 1 connected 6001-9000
3e42fdca7ecf864d200d27a62b581bec0c8c3436 192.168.32.3:6383@16383 master - 0 1582461537000 3 connected
866e8e784560dba2c46f1e6e6467dc867f3b24f5 192.168.32.4:6384@16384 master - 0 1582461538543 4 connected
```

#### 绑定从节点

   cluster replicate id

```sh
docker exec -it node-83 redis-cli -p 6383 cluster replicate 988e22fc70bae1151012fbcc5886658753b6cbe2 # to 6380
docker exec -it node-84 redis-cli -p 6384 cluster replicate 183a22026d486f19e05970a4642ce66c4733a03f # to 6381
docker exec -it node-85 redis-cli -p 6385 cluster replicate ba6eaf31cab4b080a0ef26f022565d49f554cfce # to 6382

127.0.0.1:6380> cluster nodes
ba6eaf31cab4b080a0ef26f022565d49f554cfce 192.168.32.7:6382@16382 master - 0 1582461537000 5 connected 9001-16383
d6b6dfc2af537d755558d7439fff27f18105ec61 192.168.32.2:6385@16385 master - 0 1582461536478 0 connected
988e22fc70bae1151012fbcc5886658753b6cbe2 192.168.32.5:6380@16380 myself,master - 0 1582461538000 2 connected 0-6000
183a22026d486f19e05970a4642ce66c4733a03f 192.168.32.6:6381@16381 master - 0 1582461537510 1 connected 6001-9000
3e42fdca7ecf864d200d27a62b581bec0c8c3436 192.168.32.3:6383@16383 master - 0 1582461537000 3 connected
866e8e784560dba2c46f1e6e6467dc867f3b24f5 192.168.32.4:6384@16384 master - 0 1582461538543 4 connected
127.0.0.1:6380> cluster nodes
ba6eaf31cab4b080a0ef26f022565d49f554cfce 192.168.32.7:6382@16382 master - 0 1582463993257 5 connected 9001-16383
d6b6dfc2af537d755558d7439fff27f18105ec61 192.168.32.2:6385@16385 slave ba6eaf31cab4b080a0ef26f022565d49f554cfce 0 1582463993000 5 connected
988e22fc70bae1151012fbcc5886658753b6cbe2 192.168.32.5:6380@16380 myself,master - 0 1582463991000 2 connected 0-6000
183a22026d486f19e05970a4642ce66c4733a03f 192.168.32.6:6381@16381 master - 0 1582463995321 1 connected 6001-9000
3e42fdca7ecf864d200d27a62b581bec0c8c3436 192.168.32.3:6383@16383 slave 988e22fc70bae1151012fbcc5886658753b6cbe2 0 1582463994289 3 connected
866e8e784560dba2c46f1e6e6467dc867f3b24f5 192.168.32.4:6384@16384 slave 183a22026d486f19e05970a4642ce66c4733a03f 0 1582463992225 4 connected
```

#### 模拟主备切换

```sh
docker-compose pause redis-cluster-6381

127.0.0.1:6380> cluster nodes
ba6eaf31cab4b080a0ef26f022565d49f554cfce 192.168.32.7:6382@16382 master - 0 1582464586000 5 connected 9001-16383
d6b6dfc2af537d755558d7439fff27f18105ec61 192.168.32.2:6385@16385 slave ba6eaf31cab4b080a0ef26f022565d49f554cfce 0 1582464588215 5 connected
988e22fc70bae1151012fbcc5886658753b6cbe2 192.168.32.5:6380@16380 myself,master - 0 1582464587000 2 connected 0-6000
183a22026d486f19e05970a4642ce66c4733a03f 192.168.32.6:6381@16381 master,fail - 1582464510696 1582464505535 1 connected
3e42fdca7ecf864d200d27a62b581bec0c8c3436 192.168.32.3:6383@16383 slave 988e22fc70bae1151012fbcc5886658753b6cbe2 0 1582464589252 3 connected
866e8e784560dba2c46f1e6e6467dc867f3b24f5 192.168.32.4:6384@16384 master - 0 1582464588000 6 connected 6001-9000 # 已升级为master节点
```

### 参考

* [docker-redis-cluster(Grokzen)](https://github.com/Grokzen/docker-redis-cluster)
* [redis-cluster(AliyunContainerService)](https://github.com/AliyunContainerService/redis-cluster)
* [docker-compose搭建redis集群及可用性实践](https://juejin.im/post/5d4afaaf518825403769dd44)