#!/bin/bash

set -e

if [ -z "$ASM_APT_NG_CACHER_PASSWORD" ]; then
  ASM_APT_NG_CACHER_PASSWORD=$(head /dev/random | tr -dc A-Za-z0-9  | head -c 32 ; echo '')
  echo "Your password for administrator is $ASM_APT_NG_CACHER_PASSWORD"
else
  echo "Your password for administrator is set manually using env varaibles"
fi

# generate templates
envsubst < /opt/acng/acng.conf > /etc/apt-cacher-ng/acng.conf
envsubst < /opt/acng/security.conf > /etc/apt-cacher-ng/security.conf

# setting permissions on /var/cache/apt-cacher-ng, /var/log/apt-cacher-ng, and /var/run/apt-cacher-ng
echo -n "INFO: Setting permissions on /var/cache/apt-cacher-ng, /var/log/apt-cacher-ng, and /var/run/apt-cacher-ng..."
chown -R apt-cacher-ng:apt-cacher-ng /var/cache/apt-cacher-ng /var/log/apt-cacher-ng /var/run/apt-cacher-ng
echo -e "done"

# run CMD
echo "INFO: entrypoint complete; executing CMD '${*}'"
exec "${@}"
