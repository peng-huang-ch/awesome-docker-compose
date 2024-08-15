# MongoDB Replica Set

## Create volumes

```sh
mkdir -p data/{rs1,rs2,rs3} log/{rs1,rs2,rs3}
```

## Generate access.key

```sh
openssl rand -base64 756 > access.key
```

## Launch without authentication

### comment out the following content of `mongod.conf`

```yml

```sh
   # security:
   #   keyFile: /etc/access.key
   #   authorization: enabled
```

- Startup

```sh
docker-compose up -d
```

### Init replica set

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

rs.conf() // see the conf of replica set

rs.status() // see the status of replica set

```

### Create Admin User

```sh
db.createUser({user: "admin",pwd: "password",roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]});
```

### Create Database And User

```sh
use dbname
db.auth("admin", "password");    // should return 1;
db.createUser({user: "dbOwner",pwd: "password",roles: [ { role: "dbOwner", db: "bt-node" } ]});
db.createUser({user: "write",pwd: "password",roles: [ { role: "readWrite", db: "bt-node" } ]});
db.createUser({user: "read",pwd: "password",roles: [ { role: "read", db: "bt-node" } ]});

db.grantRolesToUser("dbOwner",[ "readWrite" , { role: "readWrite", db: "bt-node" } ]);
```

## Launch with authentication

### Uncomment the following content of `mongod.conf`

```sh
security:
  keyFile: /etc/access.key
  authorization: enabled
```

- Restart

```sh
docker-compose up -d
```
