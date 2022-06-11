# Installation

```bash
docker pull ghcr.io/aasaam/apt-cacher-ng:latest
# or docker pull aasaam/apt-cacher-ng
```

```yml
# Copyright (c) 2022 aasaam software development group
version: '3'

services:
  apt-cacher-ng:
    container_name: apt-cacher-ng
    image: ghcr.io/aasaam/apt-cacher-ng:latest
    environment:
      # ${ASM_APT_NG_CACHER_USERNAME}:${ASM_APT_NG_CACHER_PASSWORD}
      ASM_APT_NG_CACHER_USERNAME: ${ASM_APT_NG_CACHER_USERNAME:-YourUserName}
      ASM_APT_NG_CACHER_PASSWORD: ${ASM_APT_NG_CACHER_PASSWORD:-YourPassw0rd}
      # configure your `PassThroughPattern`
      ASM_APT_NG_CACHER_PASS_THROUGH_PATTERN: ${ASM_APT_NG_CACHER_PASS_THROUGH_PATTERN:-^(.*):443}

      # set comment for no proxy
      # remove it to applied proxy option
      ASM_APT_NG_CACHER_NO_PROXY_COMMENT: ${ASM_APT_NG_CACHER_NO_PROXY_COMMENT:-#}
      # set proxy
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

In your Ubuntu/Debian you can use this proxy for using cache of **apt-cacher-ng**.

```txt
# /etc/apt/apt.conf.d/01proxy
acquire::http::proxy "http://hostname:8443";
acquire::https::proxy "http://hostname:8443";
```
