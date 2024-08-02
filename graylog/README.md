# Graylog

Graylog is a leading centralized log management solution built to open standards for capturing, storing, and enabling real-time analysis of terabytes of machine data.

## Introduction

- [Official Website](https://www.graylog.org/)
- [Documentation](https://docs.graylog.org/)
- [GitHub](https://github.com/Graylog2/docker-compose)

## Create data and log dir

```sh
mkdir -p {es_data,graylog_journal,mongo_data}
```

## Start

```sh
docker-compose up -d
```
