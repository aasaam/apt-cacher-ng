#!/bin/bash
set -e

# setting permissions on /var/cache/apt-cacher-ng, /var/log/apt-cacher-ng, and /var/run/apt-cacher-ng
echo -n "INFO: Setting permissions on /var/cache/apt-cacher-ng, /var/log/apt-cacher-ng, and /var/run/apt-cacher-ng..."
chown -R apt-cacher-ng:apt-cacher-ng /var/cache/apt-cacher-ng /var/log/apt-cacher-ng /var/run/apt-cacher-ng
echo -e "done"

# generate templates
envsubst < /opt/acng.conf > /etc/apt-cacher-ng/acng.conf
envsubst < /opt/security.conf > /etc/apt-cacher-ng/security.conf

# run CMD
echo "INFO: entrypoint complete; executing CMD '${*}'"
exec "${@}"
