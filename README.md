# Awesome Docker Compose

> A curated list of Docker compose resources and projects

### Thanks the following projects

- [awesome-docker](https://github.com/veggiemonk/awesome-docker) A curated list of Docker resources and projects.
- [awesome-compose](https://github.com/docker/awesome-compose) A curated list of Docker Compose samples.

## Structure

- [Components](#components)
- [Database](#database)
- [Message Queue](#message-queue)
- [Monitoring/Tracing/Logging](#monitoringtracinglogging)
- [Premises](#premises)

---

### Components

- [elasticsearch](./elasticsearch/README.md) - Elasticsearch is a distributed, RESTful search and analytics engine capable of solving a growing number of use cases.
- [logstash](./logstash/README.md) - Logstash is a server-side data processing pipeline that ingests data from multiple sources simultaneously, transforms it, and then sends it to a "stash" like Elasticsearch.
- [kibana](./kibana/README.md) - Kibana lets you visualize your Elasticsearch data and navigate the Elastic Stack.

### Database

- [mongodb](./mongodb/readme.md) - MongoDB is a NoSQL database that stores data in JSON-like documents. It is a popular choice for web applications and other projects that require a scalable, flexible database.

  - [standalone](./mongodb/standalone/README.md) - MongoDB Standalone
  - [replica set](./mongodb/replica-set/README.md) - MongoDB Replica Set
  - [sharding]() - MongoDB Sharding, TODO

- [redis](./redis/README.md) - Redis is an open source (BSD licensed), in-memory data structure store, used as a database, cache, and message broker.
  - [redis-cluster](./redis/redis-cluster/README.md)
  - [redis-sentinel](./redis/redis-sentinel/README.md)

### Message Queue

- [pulsar](./pulsar/REMADE.md) - Pulsar is a multi-tenant, high-performance solution for server-to-server messaging.

  - [standalone](./mongodb/standalone/README.md) - MongoDB Standalone
  - [replica set](./mongodb/replica-set/README.md) - MongoDB Replica Set
  - [sharding]() - MongoDB Sharding, TODO

### Monitoring/Tracing/Logging

- [dockotlp](https://github.com/peng-huang-ch/dockotlp) - A monitoring and Otel solution.
- [dockprom](https://github.com/stefanprodan/dockprom) - A monitoring solution for Docker hosts and containers with Prometheus, Grafana, cAdvisor, NodeExporter and alerting with AlertManager.
- [docker-elk](./docker-elk/README.md) - Elastic stack (ELK) on Docker
- [graylog](./graylog/README.md) - Graylog is a leading centralized log management solution built to open standards for capturing, storing, and enabling real-time analysis of terabytes of machine data.
- [getsentry](https://github.com/getsentry/self-hosted) - Sentry is an open-source platform for workflow productivity, aggregating errors from across the stack in real time.

### Premises

- [frontend](./frontend/README.md) - A simple frontend application.
- [gitlab](./gitlab/README.md) - GitLab is a web-based DevOps lifecycle tool that provides a Git repository manager providing wiki, issue-tracking and CI/CD pipeline features, using an open-source license, developed by GitLab Inc.
