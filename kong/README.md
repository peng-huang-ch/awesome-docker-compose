# `Kong` - API Gateway


`Kong` or `Kong API Gateway` is a cloud-native, platform-agnostic, scalable API Gateway distinguished for its high performance and extensibility via plugins. It is built on top of NGINX and OpenResty, and its core is implemented in Lua. It is designed to be lightweight and highly performant, and it is capable of handling a large number of requests per second.

## Overview

- [Kong](https://konghq.com/)
- [Documentation](https://www.elastic.co/docs)
- [GitHub](https://github.com/Kong/kong)
- [Docker Hub](https://hub.docker.com/_/kong)
  
> You can find the latest Compose file in the [Kong in Docker Compose](https://github.com/Kong/docker-kong/blob/master/compose/README.md) which is the official Docker Compose template for Kong Gateway.

## How to use this Compose file

Kong Gateway can be deployed in different ways. This Docker Compose file provides
support for running Kong in [db-less][kong-docs-dbless] mode, in which only a Kong
container is spun up, or with a backing database. The default is db-less mode:

create the necessary directories

```shell
mkdir -p data/{kong,prefix,tmp} 
```

Then, run the following command to start Kong in db-less mode:
```shell
docker compose up -d
```

This command will result in a single Kong Docker container:

```shell
docker compose ps
NAME                IMAGE               COMMAND                  SERVICE             CREATED             STATUS                    PORTS
kong-kong-1      kong:latest         "/docker-entrypoint.…"   kong                38 seconds ago      Up 29 seconds (healthy)   0.0.0.0:8000->8000/tcp, 127.0.0.1:8001->8001/tcp, 0.0.0.0:8443->8443/tcp, 127.0.0.1:8444->8444/tcp
```

Kong entities can be configured through the `config/kong.yaml` declarative config
file. Its format is further described [here][kong-docs-dbless-file].

You can also run Kong with a backing Postgres database:

```shell
KONG_DATABASE=postgres docker compose --profile database up -d

```

Which will result in two Docker containers running -- one for Kong itself, and
another for the Postgres instance it uses to store its configuration entities:

```shell
$ docker compose ps
NAME                IMAGE               COMMAND                  SERVICE             CREATED              STATUS                        PORTS
kong-db-1     postgres:13                 "docker-entrypoint.s…"   db        About a minute ago   Up 55 seconds (healthy)   0.0.0.0:5555->5432/tcp
kong-kong-1   kong/kong-gateway:3.7.0.0   "/entrypoint.sh kong…"   kong      About a minute ago   Up 55 seconds (healthy)   0.0.0.0:8000-8002->8000-8002/tcp, 8003-8004/tcp, 0.0.0.0:8443-8444->8443-8444/tcp, 8445-8447/tcp
```

Kong will be available on port `8000` and `8001`. You can customize the template
with your own environment variables or datastore configuration.

## Notes

> Kong Manager only available in the Enterprise version of Kong. You can use the kong:kong-gateway tag to use the open-source version of Kong.

[kong-docs-url]: https://docs.konghq.com/
[kong-docs-dbless]: https://docs.konghq.com/gateway/latest/production/deployment-topologies/db-less-and-declarative-config/#main
[kong-docs-dbless-file]: https://docs.konghq.com/gateway/latest/production/deployment-topologies/db-less-and-declarative-config/#declarative-configuration-format
[kong-docker-url]: https://hub.docker.com/_/kong
[github-new-issue]: https://github.com/Kong/docker-kong/issues/new
