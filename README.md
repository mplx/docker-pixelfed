# Pixelfed-in-a-Container

**WORK IN PROGRESS - USE AT YOUR OWN RISK**

Currently the Docker image is just available for master development tree: `docker pull mplx/docker-pixelfed:master`

[![](https://images.microbadger.com/badges/version/mplx/docker-pixelfed:master.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)
[![](https://images.microbadger.com/badges/image/mplx/docker-pixelfed:master.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)
[![](https://img.shields.io/docker/pulls/mplx/docker-pixelfed.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)

[pixelfed](https://github.com/pixelfed/pixelfed) is a [federated](https://fediverse.party/) Instagram-like photo sharing for everyone developed by [@dansup](https://github.com/dansup). This project puts it in a docker container.

- Based on [Alpine Linux 3.11 w/ PHP 7.3](https://hub.docker.com/r/gmitirol/alpine311-php73)
- Source available at [Github](https://github.com/mplx/docker-pixelfed)
- Autobuild at [DockerHub](https://hub.docker.com/r/mplx/docker-pixelfed)
- MultiArch (supports amd64, arm32v6, arm32v7 and arm32v8; however just amd64 is *extensively* tested. Yes, it will run on *Raspi* and other *Pi*'s)

Additional services required:
- [Database](https://docs.pixelfed.org/technical-documentation/env.html#database-configuration) (MySQL 5.6+/MariaDB 10.2.7+, PostgreSQL 10+)
- [Redis](https://docs.pixelfed.org/technical-documentation/env.html#redis-configuration)

See sample configuration for usage:
  - [mysql.env.sample](./mysql.env.sample)
  - [pixelfed.env.sample](./pixelfed.env.sample)
  - [swarm.yml.sample](./swarm.yml.sample)
