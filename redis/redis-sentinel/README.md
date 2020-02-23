# 说明

本项目是在[redis-sentinel-sample](https://github.com/TomCzHen/redis-sentinel-sample)上过来的，只是用于演示sentinel下的故障迁移，部署请直接参考原来项目

请先查看`redis-sentinel-sample`的[说明文档](./redis-sentinel-sample.md)

创建挂载目录 `mkdir -p data/{master,node-1,node-2,sentinel-1,sentinel-2,sentinel-3}/{data,logs}`

---

## 主要部分

- [Info](#Info)
  - [Server](#server)
  - [Master](#Master)
  - [Slave](#Slave)
  - [Sentinel](#Sentinel)
- [主从同步](#%e4%b8%bb%e4%bb%8e%e5%90%8c%e6%ad%a5)
  - [全量同步](#%e5%85%a8%e9%87%8f%e5%90%8c%e6%ad%a5)
  - [部分同步](#%e9%83%a8%e5%88%86%e5%90%8c%e6%ad%a5)
- [故障迁移](#%e6%95%85%e9%9a%9c%e8%bf%81%e7%a7%bb)
  - [Follower1](#Follower1)
  - [Follower2](#Follower2)
  - [Leader](#Leader)

---

### Info

#### Server

    redis_mode=standalone 运行模式standalone/sentinel/cluster

#### Master

    role:master # 角色 master
    connected_slaves:2 # 数目 slaves

```log
127.0.0.1:6379> info
# Server
redis_version:4.0.8
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:855b842565307359
redis_mode:standalone
arch_bits:64
multiplexing_api:epoll
atomicvar_api:atomic-builtin
gcc_version:6.4.0
process_id:1
run_id:736e72d099874aab400aba3cefe27bc71c48c466
tcp_port:6379
uptime_in_seconds:2382
uptime_in_days:0
hz:10
lru_clock:5330552
executable:/data/redis-server

# Persistence
loading:0
rdb_changes_since_last_save:3
rdb_bgsave_in_progress:0
rdb_last_save_time:1582386476
rdb_last_bgsave_status:ok
rdb_last_bgsave_time_sec:1
rdb_current_bgsave_time_sec:-1
rdb_last_cow_size:237568
aof_enabled:0
aof_rewrite_in_progress:0
aof_rewrite_scheduled:0
aof_last_rewrite_time_sec:-1
aof_current_rewrite_time_sec:-1
aof_last_bgrewrite_status:ok
aof_last_write_status:ok
aof_last_cow_size:0

# Replication
role:master # Replication master
connected_slaves:2
slave0:ip=172.22.0.3,port=6381,state=online,offset=483631,lag=0
slave1:ip=172.22.0.4,port=6380,state=online,offset=483770,lag=0
master_replid:e4f4c7d8ba28ff2102b18d049017991f98abd34d
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:483770
second_repl_offset:-1
repl_backlog_active:1
repl_backlog_size:1048576
repl_backlog_first_byte_offset:1
repl_backlog_histlen:483770
```

#### Slave
  
    role:slave
    master_host:172.22.0.2
    master_port:6379

```log
127.0.0.1:6380> info
# Server
redis_version:4.0.8
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:855b842565307359
redis_mode:standalone
os:Linux 4.19.76-linuxkit x86_64
arch_bits:64
multiplexing_api:epoll
atomicvar_api:atomic-builtin
gcc_version:6.4.0
process_id:1
run_id:be3aa0f89cd82908fb7db3a2c04be1b6ddfbccaa
tcp_port:6380

# Replication
role:slave
master_host:172.22.0.2
master_port:6379
master_link_status:up
master_last_io_seconds_ago:1
master_sync_in_progress:0
slave_repl_offset:566757
slave_priority:100
slave_read_only:1
connected_slaves:0
master_replid:e4f4c7d8ba28ff2102b18d049017991f98abd34d
master_replid2:0000000000000000000000000000000000000000
master_repl_offset:566757
second_repl_offset:-1
repl_backlog_active:1
repl_backlog_size:1048576
repl_backlog_first_byte_offset:1
repl_backlog_histlen:566757
```

#### Sentinel
  
    role:slave
    master_host:172.22.0.2
    master_port:6379

```log
127.0.0.1:26379> info
# Server
redis_version:4.0.8
redis_git_sha1:00000000
redis_git_dirty:0
redis_build_id:855b842565307359
redis_mode:sentinel
os:Linux 4.19.76-linuxkit x86_64
arch_bits:64
multiplexing_api:epoll
atomicvar_api:atomic-builtin
gcc_version:6.4.0
process_id:1
run_id:254b33ac85527ab419f01c37a1eddb22aefb432b
tcp_port:26379
uptime_in_seconds:52416
uptime_in_days:0
hz:18
lru_clock:5380590
executable:/data/redis-server
config_file:/etc/redis/sentinel.conf

# Clients
connected_clients:3
client_longest_output_list:0
client_biggest_input_buf:0
blocked_clients:0

# CPU
used_cpu_sys:282.29
used_cpu_user:36.83
used_cpu_sys_children:0.01
used_cpu_user_children:0.00

# Stats
total_connections_received:3
total_commands_processed:143242
instantaneous_ops_per_sec:2
total_net_input_bytes:8005492
total_net_output_bytes:858947
instantaneous_input_kbps:0.12
instantaneous_output_kbps:0.02
rejected_connections:0
sync_full:0
sync_partial_ok:0
sync_partial_err:0
expired_keys:0
evicted_keys:0
keyspace_hits:0
keyspace_misses:0
pubsub_channels:0
pubsub_patterns:0
latest_fork_usec:0
migrate_cached_sockets:0
slave_expires_tracked_keys:0
active_defrag_hits:0
active_defrag_misses:0
active_defrag_key_hits:0
active_defrag_key_misses:0

# Sentinel
sentinel_masters:1
sentinel_tilt:0
sentinel_running_scripts:0
sentinel_scripts_queue_length:0
sentinel_simulate_failure_flags:0
master0:name=redis-master,status=ok,address=172.22.0.4:6380,slaves=2,sentinels=3
```

### 主从同步

- 从服务器连接主服务器，发送SYNC命令
- 主服务器接收到SYNC命名后，开始执行bgsave命令生成RDB文件并使用缓冲区记录此后执行的所有写命令
- 主服务器basave执行完后，向所有从服务器发送快照文件，并在发送期间继续记录被执行的写命令
- 从服务器收到快照文件后丢弃所有旧数据，载入收到的快照
- 主服务器快照发送完毕后开始向从服务器发送缓冲区中的写命令
- 从服务器完成对快照的载入，开始接收命令请求，并执行来自主服务器缓冲区的写命令

#### 全量同步

master log  

```log
1:M 22 Feb 15:47:55.650 * Slave 172.22.0.3:6381 asks for synchronization 主服务器接收到SYNC命名
1:M 22 Feb 15:47:55.656 * Full resync requested by slave 172.22.0.3:6381
1:M 22 Feb 15:47:55.662 * Starting BGSAVE for SYNC with target: disk 开始执行bgsave命令生成RDB文件
1:M 22 Feb 15:47:55.667 * Background saving started by pid 12
12:C 22 Feb 15:47:55.683 * DB saved on disk
12:C 22 Feb 15:47:55.697 * RDB: 0 MB of memory used by copy-on-write
1:M 22 Feb 15:47:55.786 * Background saving terminated with success
1:M 22 Feb 15:47:55.817 * Synchronization with slave 172.22.0.3:6381 succeeded
```

slave log  

```slave log
1:S 22 Feb 15:47:55.744 # Server initialized
1:S 22 Feb 15:47:55.752 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
1:S 22 Feb 15:47:55.763 * Ready to accept connections
1:S 22 Feb 15:47:55.768 * Connecting to MASTER master:6379 建立连接
1:S 22 Feb 15:47:55.781 * MASTER <-> SLAVE sync started 开始同步
1:S 22 Feb 15:47:55.786 * Non blocking connect for SYNC fired the event.
1:S 22 Feb 15:47:55.833 * Master replied to PING, replication can continue...
1:S 22 Feb 15:47:55.879 * Partial resynchronization not possible (no cached master)
1:S 22 Feb 15:47:55.929 * Full resync from master: e4f4c7d8ba28ff2102b18d049017991f98abd34d:0
1:S 22 Feb 15:47:56.059 * MASTER <-> SLAVE sync: receiving 175 bytes from master
1:S 22 Feb 15:47:56.081 * MASTER <-> SLAVE sync: Flushing old data
1:S 22 Feb 15:47:56.132 * MASTER <-> SLAVE sync: Loading DB in memory
1:S 22 Feb 15:47:56.165 * MASTER <-> SLAVE sync: Finished with success
1:S 22 Feb 15:50:59.399 # Connection with master lost.
1:S 22 Feb 15:50:59.401 * Caching the disconnected master state.
1:S 22 Feb 15:50:59.406 * SLAVE OF 172.22.0.2:6379 enabled (user request from 'id=3 addr=172.22.0.7:33020 fd=9 name=sentinel-15a67098-cmd age=181 idle=0 flags=x db=0 sub=0 psub=0 multi=3 qbuf=0 qbuf-free=32768 obl=36 oll=0 omem=0 events=r cmd=exec')
1:S 22 Feb 15:51:00.104 * Connecting to MASTER 172.22.0.2:6379
1:S 22 Feb 15:51:00.111 * MASTER <-> SLAVE sync started
1:S 22 Feb 15:51:00.121 * Non blocking connect for SYNC fired the event.
1:S 22 Feb 15:51:00.127 * Master replied to PING, replication can continue...
1:S 22 Feb 15:51:00.133 * Trying a partial resynchronization (request e4f4c7d8ba28ff2102b18d049017991f98abd34d:36694).
1:S 22 Feb 15:51:00.149 * Successful partial resynchronization with master.
1:S 22 Feb 15:51:00.153 * MASTER <-> SLAVE sync: Master accepted a Partial Resynchronization.
```

#### 部分同步

> runid(replication ID): 主服务器运行id。 
> Redis实例在启动时，随机生成一个长度40的唯一字符串来标识当前节点
>
> offset: 复制偏移量。主服务器和从服务器各自维护一个复制偏移量: 记录传输的字节数。当主节点向从节点发送N个字节数据时，主节点的offset增加N，从节点收到主节点传来的N个字节数据时，从节点的offset增加N
>
> replication backlog buffer: 复制积压缓冲区。是一个固定长度的FIFO队列，大小由配置参数repl-backlog-size指定，默认大小1MB。需要注意的是该缓冲区由master维护并且有且只有一个，所有slave共享此缓冲区，其作用在于备份最近主库发送给从库的数据

- 当slave连接到master，会执行PSYNC <runid> <offset>发送记录旧的master的runid（replication ID）和偏移量offse
- master发送slave所缺的增量部分

master log  

```log
1:M 22 Feb 15:51:00.137 * Slave 172.22.0.4:6380 asks for synchronization
1:M 22 Feb 15:51:00.145 * Partial resynchronization request from 172.22.0.4:6380 accepted. Sending 278 bytes of backlog starting from offset 36694.
```

slave log  

```slave log
1:S 22 Feb 15:51:00.133 * Trying a partial resynchronization (request e4f4c7d8ba28ff2102b18d049017991f98abd34d:36694).
1:S 22 Feb 15:51:00.149 * Successful partial resynchronization with master.
1:S 22 Feb 15:51:00.153 * MASTER <-> SLAVE sync: Master accepted a Partial Resynchronization.
```

### 故障迁移

转移操作由以下步骤组成：
- 发现主服务器已经进入客观下线状态。
- 对我们的当前纪元进行自增（详情请参考 Raft leader election ）， 并尝试在这个纪元中当选。
- 如果当选失败， 那么在设定的故障迁移超时时间的两倍之后， 重新尝试当选。 如果当选成功， 那么执行以下步骤。
- 选出一个从服务器，并将它升级为主服务器。
- 向被选中的从服务器发送 SLAVEOF NO ONE 命令，让它转变为主服务器。
- 通过发布与订阅功能， 将更新后的配置传播给所有其他 Sentinel， 其他 Sentinel 对它们自己的配置进行更新。
- 向已下线主服务器的从服务器发送 SLAVEOF host port 命令，让它们去复制新的主服务器。
- 当所有从服务器都已经开始复制新的主服务器时，领头 Sentinel 终止这次故障迁移操作

#### Follower1

`15a670981f211ae4cfaef2855819485b56225e13`

```log
1:X 23 Feb 04:58:08.137 # +new-epoch 1
1:X 23 Feb 04:58:08.146 # +vote-for-leader 4230cd10f36ab9effd8e21ee33a8f63f5e1fe28f 1
1:X 23 Feb 04:58:08.544 # +sdown master redis-master 172.22.0.2 6379 # 主观下线
1:X 23 Feb 04:58:08.620 # +odown master redis-master 172.22.0.2 6379 #quorum 3/2 # 客观下线
1:X 23 Feb 04:58:08.623 # Next failover delay: I will not start a failover before Sun Feb 23 05:04:08 2020
1:X 23 Feb 04:58:09.293 # +config-update-from sentinel 4230cd10f36ab9effd8e21ee33a8f63f5e1fe28f 172.22.0.5 26379 @ redis-master 172.22.0.2 6379  # 172.22.0.5 # 同步新配置
1:X 23 Feb 04:58:09.297 # +switch-master redis-master 172.22.0.2 6379 172.22.0.4 6380 选举出了新master 6380
1:X 23 Feb 04:58:09.304 * +slave slave 172.22.0.3:6381 172.22.0.3 6381 @ redis-master 172.22.0.4 6380 # 6381 同步 6380
1:X 23 Feb 04:58:09.308 * +slave slave 172.22.0.2:6379 172.22.0.2 6379 @ redis-master 172.22.0.4 6380 # 6379 降级为 6380
1:X 23 Feb 04:58:12.329 # +sdown slave 172.22.0.2:6379 172.22.0.2 6379 @ redis-master 172.22.0.4 6380 # 主观下线 6379
```

#### Follower2

`8c62aea94ee454dfccf2d5eaead8f909071c71d1`

```log
1:X 23 Feb 04:58:07.759 # +sdown master redis-master 172.22.0.2 6379
1:X 23 Feb 04:58:08.139 # +new-epoch 1
1:X 23 Feb 04:58:08.148 # +vote-for-leader 4230cd10f36ab9effd8e21ee33a8f63f5e1fe28f 1
1:X 23 Feb 04:58:08.880 # +odown master redis-master 172.22.0.2 6379 #quorum 3/2
1:X 23 Feb 04:58:08.883 # Next failover delay: I will not start a failover before Sun Feb 23 05:04:08 2020
1:X 23 Feb 04:58:09.297 # +config-update-from sentinel 4230cd10f36ab9effd8e21ee33a8f63f5e1fe28f 172.22.0.5 26379 @ redis-master 172.22.0.2 6379 # 更改配置信息
1:X 23 Feb 04:58:09.305 # +switch-master redis-master 172.22.0.2 6379 172.22.0.4 6380 # 切换主节点
1:X 23 Feb 04:58:09.312 * +slave slave 172.22.0.3:6381 172.22.0.3 6381 @ redis-master 172.22.0.4 6380
1:X 23 Feb 04:58:09.319 * +slave slave 172.22.0.2:6379 172.22.0.2 6379 @ redis-master 172.22.0.4 6380
1:X 23 Feb 04:58:12.347 # +sdown slave 172.22.0.2:6379 172.22.0.2 6379 @ redis-master 172.22.0.4 6380
```

#### Leader

id `4230cd10f36ab9effd8e21ee33a8f63f5e1fe28f`
role leader
 
```log
1:X 23 Feb 04:58:07.990 # +sdown master redis-master 172.22.0.2 6379 主观下线
1:X 23 Feb 04:58:08.111 # +odown master redis-master 172.22.0.2 6379 #quorum 2/2 客观下线
1:X 23 Feb 04:58:08.113 # +new-epoch 1 新的epoch
1:X 23 Feb 04:58:08.117 # +try-failover master redis-master 172.22.0.2 6379 开始故障前期，等待投票
1:X 23 Feb 04:58:08.127 # +vote-for-leader 4230cd10f36ab9effd8e21ee33a8f63f5e1fe28f 1 # 投票
1:X 23 Feb 04:58:08.152 # 15a670981f211ae4cfaef2855819485b56225e13 voted for 4230cd10f36ab9effd8e21ee33a8f63f5e1fe28f 1 # 投票
1:X 23 Feb 04:58:08.155 # 8c62aea94ee454dfccf2d5eaead8f909071c71d1 voted for 4230cd10f36ab9effd8e21ee33a8f63f5e1fe28f 1 # 投票
1:X 23 Feb 04:58:08.207 # +elected-leader master redis-master 172.22.0.2 6379 # 6379 master
1:X 23 Feb 04:58:08.209 # +failover-state-select-slave master redis-master 172.22.0.2 6379 # 正在寻找可以升级为主服务器的从服务器
1:X 23 Feb 04:58:08.294 # +selected-slave slave 172.22.0.4:6380 172.22.0.4 6380 @ redis-master 172.22.0.2 6379 # 顺利找到适合进行升级的从服务器6380
1:X 23 Feb 04:58:08.298 * +failover-state-send-slaveof-noone slave 172.22.0.4:6380 172.22.0.4 6380 @ redis-master 172.22.0.2 6379  # 正在将指定的从服务器升级为主服务器
1:X 23 Feb 04:58:08.386 * +failover-state-wait-promotion slave 172.22.0.4:6380 172.22.0.4 6380 @ redis-master 172.22.0.2 6379 # 等待6381节点升级为主节点
1:X 23 Feb 04:58:09.229 # +promoted-slave slave 172.22.0.4:6380 172.22.0.4 6380 @ redis-master 172.22.0.2 6379 # 确认6380节点已经升级为主节点
1:X 23 Feb 04:58:09.234 # +failover-state-reconf-slaves master redis-master 172.22.0.2 6379  # failover进入重新配置从节点阶段
1:X 23 Feb 04:58:09.286 * +slave-reconf-sent slave 172.22.0.3:6381 172.22.0.3 6381 @ redis-master 172.22.0.2 6379 # 6381节点配置新的主节点
1:X 23 Feb 04:58:10.246 * +slave-reconf-inprog slave 172.22.0.3:6381 172.22.0.3 6381 @ redis-master 172.22.0.2 6379 # 同步过程尚未完成
1:X 23 Feb 04:58:10.255 * +slave-reconf-done slave 172.22.0.3:6381 172.22.0.3 6381 @ redis-master 172.22.0.2 6379 # 同步过程完成
1:X 23 Feb 04:58:10.296 # -odown master redis-master 172.22.0.2 6379
1:X 23 Feb 04:58:10.298 # +failover-end master redis-master 172.22.0.2 6379 # failover切换完成
1:X 23 Feb 04:58:10.305 # +switch-master redis-master 172.22.0.2 6379 172.22.0.4 6380 # 切换主节点
1:X 23 Feb 04:58:10.310 * +slave slave 172.22.0.3:6381 172.22.0.3 6381 @ redis-master 172.22.0.4 6380 # 关联新主节点的slave信息
1:X 23 Feb 04:58:10.313 * +slave slave 172.22.0.2:6379 172.22.0.2 6379 @ redis-master 172.22.0.4 6380 # 关联新主节点的slave信息
1:X 23 Feb 04:58:13.334 # +sdown slave 172.22.0.2:6379 172.22.0.2 6379 @ redis-master 172.22.0.4 6380 # 判定原来的主节点(6379)主观下线
``` 