# apt-cacher-ng

[![aasaam](https://flat.badgen.net/badge/aasaam/software%20development%20group/0277bd?labelColor=000000&icon=https%3A%2F%2Fcdn.jsdelivr.net%2Fgh%2Faasaam%2Finformation%2Flogo%2Faasaam.svg)](https://github.com/aasaam)

[![Docker Image Size](https://flat.badgen.net/docker/size/aasaam/apt-cacher-ng)](https://hub.docker.com/r/aasaam/apt-cacher-ng)
[![Docker Repository on Quay](https://flat.badgen.net/badge/quay.io/repo/cyan)](https://quay.io/repository/aasaam/apt-cacher-ng)

[![open-issues](https://flat.badgen.net/github/open-issues/aasaam/apt-cacher-ng)](https://github.com/aasaam/apt-cacher-ng/issues)
[![open-pull-requests](https://flat.badgen.net/github/open-prs/aasaam/apt-cacher-ng)](https://github.com/aasaam/apt-cacher-ng/pulls)
[![license](https://flat.badgen.net/github/license/aasaam/apt-cacher-ng)](./LICENSE)

[apt-cacher-ng](http://www.unix-ag.uni-kl.de/~bloch/acng/) is for cache apt packages.

This container is useful for speedup development process and saving bandwidth.

```bash
docker pull aasaam/apt-cacher-ng
# or docker pull quay.io/aasaam/apt-cacher-ng
```

```yml
version: '3'

services:
  apt-cacher-ng:
    container_name: apt-cacher-ng
    image: aasaam/apt-cacher-ng
    ports:
      - 8443:8443 # apt-cacher-ng
    volumes:
      - cache-storage:/var/lib/apt-cacher-ng
      # - ./addon/security.conf:/etc/apt-cacher-ng/security.conf:ro
    dns:
      - 127.0.0.1
    restart: unless-stopped

volumes:
  cache-storage:
```

In your Ubuntu/Debian you can use this proxy for using cache of **apt-cacher-ng**.

```txt
# /etc/apt/apt.conf.d/01proxy
acquire::http::proxy "http://hostname:8443";
acquire::https::proxy "http://hostname:8443";
```
