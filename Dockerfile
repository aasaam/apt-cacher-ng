FROM ubuntu:focal

LABEL org.label-schema.name="apt-cacher-ng" \
      org.label-schema.description="apt-cacher-ng" \
      org.label-schema.url=https://github.com/aasaam/apt-cacher-ng \
      org.label-schema.vendor="aasaam" \
      maintainer="Muhammad Hussein Fattahizadeh <m@mhf.ir>"

RUN export DEBIAN_FRONTEND=noninteractive ; \
  apt update \
  && apt upgrade -y \
  && apt install cron apt-cacher-ng python3 python3-distutils curl ca-certificates jq --no-install-recommends -y \
  && cd /tmp \
  && export GOST_URL=$(curl -s https://api.github.com/repos/ginuerzh/gost/releases/latest | jq -r '.assets[].browser_download_url | select(contains("linux-amd64"))') \
  && curl -sL $GOST_URL -o gost.gz \
  && gunzip gost.gz \
  && chmod +x gost \
  && mv gost /usr/bin/gost \
  && curl -sL https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
  && python3 get-pip.py \
  && pip install supervisor \
  && apt-get purge curl jq python3-distutils -y \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /root/.cache && rm -r /var/lib/apt/lists/* && rm -rf /tmp && mkdir /tmp && chmod 777 /tmp && truncate -s 0 /var/log/*.log

ADD config/interval.sh /interval.sh
ADD config/supervisor.ini /supervisor.ini
ADD config/config.json /etc/gost.json
ADD config/acng.conf /etc/apt-cacher-ng/acng.conf
ADD config/security.conf /etc/apt-cacher-ng/security.conf

VOLUME ["/var/lib/apt-cacher-ng"]

CMD ["/usr/local/bin/supervisord", "-c", "/supervisor.ini"]
