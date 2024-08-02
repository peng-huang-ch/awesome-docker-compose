# `Traefik Proxy` is a reverse proxy and load balancing solution focused on micro services.

This setup comes up with the [Traefik](https://github.com/traefik/traefik) v3.1.1 reverse proxy to access the Portainer instance via a virtual host, has support for SSL certificates using Let's Encrypt and automatic redirection from http to https.

> You can find the documentation [`Deploying Portainer behind Traefik Proxy`](https://docs.portainer.io/v/2.20/advanced/reverse-proxy/traefik)

## How to use this Compose file

### Deploying in a Docker Standalone scenario
```shell
docker-compose up -d
```

### Deploying in a Docker Swarm scenario
```shell
docker stack deploy -c docker-compose.yml portainer
```