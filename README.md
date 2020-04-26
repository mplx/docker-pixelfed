# Pixelfed-in-a-Container

**WORK IN PROGRESS - USE AT YOUR OWN RISK**

Currently the Docker image is just available for master development tree: `docker pull mplx/docker-pixelfed:master`

[![](https://images.microbadger.com/badges/version/mplx/docker-pixelfed.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)
[![](https://images.microbadger.com/badges/image/mplx/docker-pixelfed.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)
[![](https://img.shields.io/docker/pulls/mplx/docker-pixelfed.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)

[pixelfed](https://github.com/pixelfed/pixelfed) is a [federated](https://fediverse.party/) Instragram-like photo sharing for everyone developed by [@dansup](https://github.com/dansup). This project puts it in a docker container.

- Based on Alpine Linux 3.11 w/ PHP 7.3
- Source available at Github
- Autobuild at DockerHub
- MultiArch (supports amd64, arm32v6, arm32v7 and arm32v8; however just amd64 is *extensively* tested)

Additional services required:
- [Database](https://docs.pixelfed.org/technical-documentation/env.html#database-configuration) (MySQL/MariaDB, PostgreSQL or SQLite)
- [Redis](https://docs.pixelfed.org/technical-documentation/env.html#redis-configuration)

See sample configuration for usage:
  - [mysql.env.sample](./mysql.env.sample)
  - [pixelfed.env.sample](./pixelfed.env.sample)
  - [swarm.yml.sample](./swarm.yml.sample)
