FROM resin/rpi-raspbian:stretch

MAINTAINER Gwendal CHARLES <gwendaldev@gmail.com>

# Install Domoticz from sources.
RUN apt-get update && apt-get install -y cmake apt-utils build-essential curl
RUN apt-get install -y libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev libcurl4-openssl-dev libusb-dev zlib1g-dev
RUN apt-get install -y libcurl4-gnutls-dev
RUN apt-get install -y iputils-ping
RUN apt-get clean && apt-get autoclean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add packages in container
ADD domoticz_linux_armv7l.tgz /root/domoticz

# Expose port.
EXPOSE 8080

CMD ["/root/domoticz/domoticz", "-www", "8080"]
