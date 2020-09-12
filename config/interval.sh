#!/bin/bash
while :
do
  chown -R apt-cacher-ng:apt-cacher-ng /var/cache/apt-cacher-ng
  chmod -R a+rX,g+rw,u+rw /var/cache/apt-cacher-ng
  sleep 3600
done
