# Installation

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
