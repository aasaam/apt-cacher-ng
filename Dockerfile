FROM debian:bullseye-slim

RUN export DEBIAN_FRONTEND=noninteractive ; \
  apt update \
  && apt upgrade -y \
  && apt install -y --no-install-recommends apt-cacher-ng ca-certificates cron curl gettext-base logrotate rsyslog s6 \
  && apt-get autoremove -y \
  && apt-get clean \
  && sed -i "s#size 10M#size 128M#g" /etc/logrotate.d/apt-cacher-ng \
  && sed -i '/imklog/s/^/#/' /etc/rsyslog.conf \
  && echo 'cache' > /usr/share/doc/apt-cacher-ng/cache.txt \
  && rm /etc/apt-cacher-ng -rf \
  && rm -r /var/lib/apt/lists/* && rm -rf /tmp && mkdir /tmp && chmod 777 /tmp && truncate -s 0 /var/log/*.log

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
  CMD curl -sL -o /dev/null  http://127.0.0.1:3142/acng-report.html || exit 1

EXPOSE 3142/tcp

ADD apt-cacher-ng /etc/apt-cacher-ng
ADD s6 /etc/s6
ADD opt /opt/acng
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["s6-svscan","/etc/s6"]
