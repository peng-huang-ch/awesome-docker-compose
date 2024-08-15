# Awesome Docker Compose

> A curated list of Docker compose resources and projects

### Acknowledgements

- [awesome-docker](https://github.com/veggiemonk/awesome-docker) A curated list of Docker resources and projects. By [@veggiemonk](https://github.com/veggiemonk)
- [awesome-compose](https://github.com/docker/awesome-compose) A curated list of Docker Compose samples. By [@docker](https://github.com/docker)
- [awesome-sysadmin](https://github.com/awesome-foss/awesome-sysadmin) A curated list of amazingly awesome Free and Open-Source sysadmin resources. By [@awesome-foss](https://github.com/awesome-foss)
- [docker-compose](https://github.com/awesome-startup/docker-compose) A curated list of Docker Compose samples for startups. By [@awesome-startup](https://github.com/awesome-startup)

## Structure

- [API Gateway](#api-gateway)
- [Components](#components)
- [Database](#database)
- [Message Queue](#message-queue)
- [Monitoring/Tracing/Logging](#monitoringtracinglogging)
- [Additional](#additional)

---

### API Gateway

- [kong](./kong/README.md) - Kong is a scalable, open source API Layer (also known as an API Gateway, or API Middleware). Kong runs in front of any RESTful API and is extended through plugins, which provide extra functionality and services beyond the core platform.

### Components

- [elastic](https://www.elastic.co) - Elastic Stack (ELK) on Docker
  - [logstash](https://www.elastic.co/logstash) - Logstash is a server-side data processing pipeline that ingests data from multiple sources simultaneously, transforms it, and then sends it to a "stash" like Elasticsearch.
  - [kibana](https://www.elastic.co/kibana) - Kibana lets you visualize your Elasticsearch data and navigate the Elastic Stack.

### Database

- [mongodb](./mongodb/readme.md) - MongoDB is a NoSQL database that stores data in JSON-like documents. It is a popular choice for web applications and other projects that require a scalable, flexible database.

  - [standalone](./mongodb/standalone/README.md) - MongoDB Standalone
  - [replica set](./mongodb/replica-set/README.md) - MongoDB Replica Set
  - [sharding]() - MongoDB Sharding, TODO

- [redis](./redis/README.md) - Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache, and message broker.
  - [redis-cluster](./redis/redis-cluster/README.md)
  - [redis-sentinel](./redis/redis-sentinel/README.md)

- [elasticsearch](./elasticsearch/README.md#elasticsearch) - Elasticsearch is a distributed, RESTful search and analytics engine capable of solving a growing number of use cases.

### Message Queue

- [pulsar](./pulsar/README.md) - Pulsar is a multi-tenant, high-performance solution for server-to-server messaging.

  - [standalone](./pulsar/pulsar-standone/README.md) - Pulsar Standalone
  - [cluster](./pulsar/pulsar-cluster/README.md) - Pulsar Cluster

### Monitoring/Tracing/Logging

- [dockotlp](https://github.com/peng-huang-ch/dockotlp) - A monitoring and Otel solution for Docker hosts and containers with Prometheus, Grafana, Loki, Promtail, Tempo and alerting with AlertManager.
- [dockprom](https://github.com/stefanprodan/dockprom) - A monitoring solution for Docker hosts and containers with Prometheus, Grafana, cAdvisor, NodeExporter and alerting with AlertManager.
- [elastic-stack](./elastic-stack/README.md) - Elastic stack (ELK) on Docker
- [graylog](./graylog/README.md) - Graylog is a leading centralized log management solution built to open standards for capturing, storing, and enabling real-time analysis of terabytes of machine data.
- [getsentry](https://github.com/getsentry/self-hosted) - Sentry is an open-source platform for workflow productivity, aggregating errors from across the stack in real time.
- [jaeger](./jaeger/README.md) - Jaeger, a Distributed Tracing System

### Additional

- [frontend](./frontend/README.md) - A simple frontend application.
- [gitlab](./gitlab/README.md) - GitLab is a web-based DevOps lifecycle tool that provides a Git repository manager providing wiki, issue-tracking and CI/CD pipeline features, using an open-source license, developed by GitLab Inc.
- [portainer](./portainer/README.md) - Portainer is an open-source lightweight management UI which allows you to easily manage your Docker host or Swarm cluster.
  - [agent](./portainer/agent/README.md) - Deploy Portainer with an agent
  - [nginx-proxy](./portainer/nginx-proxy/README.md) - Deploy Portainer with an Nginx reverse proxy
  - [traefik](./portainer/traefik/README.md) - Deploy Portainer with a Traefik reverse proxy
