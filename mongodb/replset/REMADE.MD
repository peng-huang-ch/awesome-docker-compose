# MongoDB Replica Set

## Create data and log dir

```sh
mkdir -p data/{rs1,rs2,rs3} log/{rs1,rs2,rs3}
```

## 生成随机 key

```sh
openssl rand -base64 756 > access.key
```

## 初始化启动

- 注释, 不启用 auth

```sh
   # security:
   #   keyFile: /etc/access.key
   #   authorization: enabled
```

- 启动

```sh
docker-compose up -d
```

- 初始化 rs

```sh
docker-compose exec rs1 mongo

rs.initiate(
   {
      _id: "myset",
      version: 1,
      members: [
         { _id: 0, host : "ip1:port1" },
         { _id: 1, host : "ip2:port2" },
         { _id: 2, host : "ip3:port3" }
      ]
   }
);

rs.conf() //查看配置

rs.status() //查看副本级状态

```

- 创建 admin 用户

```sh
db.createUser({user: "admin",pwd: "password",roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]});
```

- 创建库和用户

```sh
use dbname
db.auth("admin", "password");    // should return 1;
db.createUser({user: "dbOwner",pwd: "password",roles: [ { role: "dbOwner", db: "bt-node" } ]});
db.createUser({user: "write",pwd: "password",roles: [ { role: "readWrite", db: "bt-node" } ]});
db.createUser({user: "read",pwd: "password",roles: [ { role: "read", db: "bt-node" } ]});

db.grantRolesToUser("dbOwner",[ "readWrite" , { role: "readWrite", db: "bt-node" } ]);
```

## 开启用户认证

- 放开注释

```sh
security:
  keyFile: /etc/access.key
  authorization: enabled
```

- 启动

```sh
docker-compose up -d
```
