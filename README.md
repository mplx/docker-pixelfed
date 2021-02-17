# Pixelfed-in-a-Container

## WORK IN PROGRESS - USE AT YOUR OWN RISK - EXPERIMENTAL

Currently the docker image is just available for the master development tree: `docker pull mplx/docker-pixelfed:master`. As I'm using it myself I'm trying to keep it as stable as possible, however as long as there are no [semver](https://semver.org/) tags you should consider this image to break anytime. So if you just wanna go for a selfhosted [Pixelfed](https://pixelfed.org/) testdrive this image is fine to use, however you shouldn't daily feed your thousands of followers with it.

## mplx/docker-pixelfed

[![](https://images.microbadger.com/badges/version/mplx/docker-pixelfed:master.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)
[![](https://images.microbadger.com/badges/image/mplx/docker-pixelfed:master.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)
[![](https://img.shields.io/docker/pulls/mplx/docker-pixelfed.svg)](https://hub.docker.com/r/mplx/docker-pixelfed)

[pixelfed](https://github.com/pixelfed/pixelfed) is a [federated](https://fediverse.party/) [Instagram](https://www.instagram.com/about/us/)-like photo sharing for everyone developed by [@dansup](https://github.com/dansup). This project puts this [FOSS](https://en.wikipedia.org/wiki/Free_and_open-source_software) in a docker container.

Container:
  - Pixelfed [v0.10.10](https://github.com/pixelfed/pixelfed/releases)
  - Based on [Alpine Linux 3.11 w/ PHP 7.3](https://hub.docker.com/r/gmitirol/alpine311-php73)
  - Source available at [Github](https://github.com/mplx/docker-pixelfed)
  - Autobuild at [DockerHub](https://hub.docker.com/r/mplx/docker-pixelfed)
  - MultiArch (supports amd64, arm32v6, arm32v7 and arm32v8; however just amd64 is *extensively* tested. Yes, it will run on *Raspi* and other *Pi*'s)

Additional services required:
  - [Database](https://docs.pixelfed.org/technical-documentation/env.html#database-configuration) (MySQL 5.6+/MariaDB 10.2.7+, PostgreSQL 10+)
  - [Redis](https://docs.pixelfed.org/technical-documentation/env.html#redis-configuration)

Optional services:
  - [Reverse Proxy](https://github.com/mplx/docker-pixelfed/issues/3#issuecomment-624343083) to provide HTTPS

See sample configuration for usage:
  - [mysql.env.sample](https://raw.githubusercontent.com/mplx/docker-pixelfed/master/mysql.env.sample)
  - [pixelfed.env.sample](https://raw.githubusercontent.com/mplx/docker-pixelfed/master/pixelfed.env.sample) (see [official docs](https://docs.pixelfed.org/running-pixelfed/installation.html#configure-environment-variables))
  - [swarm.yml.sample](https://raw.githubusercontent.com/mplx/docker-pixelfed/master/swarm.yml.sample) (example for use in combination with traefik 1.x proxy)

Please feel free to [submit an issue](https://github.com/mplx/docker-pixelfed/issues/new) or merge request regarding this project anytime :) however please respect that I cannot provide basic support for Docker/Swarm/k8s nor Pixelfed.
