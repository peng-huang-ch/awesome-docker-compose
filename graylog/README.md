# Graylog

Graylog is a leading centralized log management solution built to open standards for capturing, storing, and enabling real-time analysis of terabytes of machine data.

## Overview

- [Website](https://www.graylog.org/)
- [Documentation](https://docs.graylog.org/)
- [GitHub](https://github.com/Graylog2/docker-compose)

> You can find the latest Compose file in the [Graylog2 Github](https://github.com/Graylog2/docker-compose)

## Create volumes

```sh
mkdir -p {es_data,graylog_journal,mongo_data}
```

## How to use this Compose file

```sh
docker-compose up -d
```
