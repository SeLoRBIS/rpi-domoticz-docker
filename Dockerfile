FROM resin/rpi-raspbian:stretch

MAINTAINER Gwendal CHARLES <gwendaldev@gmail.com>

RUN apt-get update \
    && apt-get install -y cmake apt-utils build-essential curl wget git \
    libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev libcurl4-openssl-dev libusb-dev zlib1g-dev \
    python3 libpython3-dev libpython3.4-dev iputils-ping

RUN apt-get install -y libcurl4-gnutls-dev

RUN apt-get clean && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /root/domoticz \
    && wget -q https://releases.domoticz.com/releases/release/domoticz_linux_armv7l.tgz \
    && tar xzf domoticz_linux_armv7l.tgz -C /root/domoticz/

VOLUME /config

EXPOSE 8080

ENTRYPOINT ["/root/domoticz/domoticz", "-dbase", "/config/domoticz.db"]

CMD ["-www", "8080"]
