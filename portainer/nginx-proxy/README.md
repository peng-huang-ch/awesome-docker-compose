# `nginx-proxy` is deploying Portainer behind nginx reverse proxy


> You can find the documentation [`Deploying Portainer behind nginx reverse proxy`](https://docs.portainer.io/v/2.20/advanced/reverse-proxy/nginx)

## How to use this Compose file

### Deploying in a Docker Standalone scenario
```shell
docker-compose up -d
```

docker ps

```shell
CONTAINER ID   IMAGE                           COMMAND                  CREATED         STATUS         PORTS                                                           NAMES
8c8f2eac7c9a   portainer/portainer-ee:2.20.3   "/portainer -H unix:…"   4 minutes ago   Up 4 minutes   9000/tcp, 0.0.0.0:8000->8000/tcp, :::8000->8000/tcp, 9443/tcp   portainer_portainer_1
3e7c8b5d71d7   nginxproxy/nginx-proxy          "/app/docker-entrypo…"   4 minutes ago   Up 4 minutes   0.0.0.0:80->80/tcp, :::80->80/tcp                               portainer_nginx-proxy_1
```

### Deploying in a Docker Swarm scenario

```shell
docker stack deploy -c docker-compose.yml portainer
```

docker service ls

```shell
ID                  NAME                    MODE                REPLICAS            IMAGE                          PORTS
gy2bjxid0g4p        portainer_agent         global              1/1                 portainer/agent:2.20.3
jwvjp5bux4sz        portainer_nginx-proxy   replicated          1/1                 nginxproxy/nginx-proxy:latest  *:80->80/tcp
5nflcvoxl3c7        portainer_portainer     replicated          1/1                 portainer/portainer-ee:2.20.3  *:8000->8000/tcp
```

