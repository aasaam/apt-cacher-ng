# Installation

```bash
docker pull ghcr.io/aasaam/apt-cacher-ng:latest
# or docker pull aasaam/apt-cacher-ng
```

Set **environment variables** and `docker-compose up -d`

```yml
# Copyright (c) 2022 aasaam software development group
version: '3'

services:
  apt-cacher-ng:
    container_name: apt-cacher-ng
    image: ghcr.io/aasaam/apt-cacher-ng:latest
    env_file:
      - ./env
    environment:
      # admin
      ASM_APT_NG_CACHER_USERNAME: ${ASM_APT_NG_CACHER_USERNAME:-acng-admin}
      # if empty will be generated each time container run, see logs
      # ASM_APT_NG_CACHER_PASSWORD: ${ASM_APT_NG_CACHER_PASSWORD:-YourPassw0rd}

      # configure your `PassThroughPattern`
      ASM_APT_NG_CACHER_PASS_THROUGH_PATTERN: ${ASM_APT_NG_CACHER_PASS_THROUGH_PATTERN:-^(.*):443}

      ASM_APT_NG_CACHER_NO_BIND_COMMENT: ${ASM_APT_NG_CACHER_NO_BIND_COMMENT:-#}
      ASM_APT_NG_CACHER_BIND_ADDRESS: ${ASM_APT_NG_CACHER_BIND_ADDRESS:-127.0.0.1}


      # set proxy if above variable is empty
      ASM_APT_NG_CACHER_NO_PROXY_COMMENT: ${ASM_APT_NG_CACHER_NO_PROXY_COMMENT:-#}
      ASM_APT_NG_CACHER_PROXY: ${ASM_APT_NG_CACHER_PROXY:-http://192.168.1.1:8080}
    ports:
      - 3142:3142 # apt-cacher-ng
    volumes:
      - cache-storage:/var/lib/apt-cacher-ng
    restart: unless-stopped
    ulimits:
      nofile:
        soft: 65536
        hard: 65536

volumes:
  cache-storage:
```

## Basic

In your Ubuntu/Debian you can use this proxy for using cache of **apt-cacher-ng**.

Assume your running this container on `http://hostname:3142`;

```txt
# /etc/apt/apt.conf.d/01proxy
acquire::http::proxy "http://hostname:3142";
acquire::https::proxy "http://hostname:3142";
```

## HTTPS caching (Recommended)

Change your sources from:

```
deb https://archive.ubuntu.com/ubuntu/ focal main restricted
```

to

```
deb https://hostname:8443/archive.ubuntu.com/ubuntu/ focal main restricted
```
