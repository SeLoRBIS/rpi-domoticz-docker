# Dockerfile for Rpi-Domoticz

# Base image.
FROM resin/rpi-raspbian:jessie

MAINTAINER Gwendal CHARLES

# Install Domoticz from sources.
RUN apt-get update && apt-get install -y cmake curl apt-utils build-essential
RUN apt-get install -y libssl1.0.0 libssl-dev libboost-all-dev libsqlite3-0 libsqlite3-dev
RUN apt-get install -y libcurl3 libcurl4-openssl-dev zlib1g-dev libudev-dev
RUN apt-get install -y libusb-0.1-4 libusb-dev
RUN apt-get install -y iputils-ping
RUN apt-get install -y python3-dev python3-pip
RUN apt-get clean && apt-get autoclean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add packages in container
ADD domoticz_linux_armv7l.tgz /root/domoticz

# Expose port.
EXPOSE 8080

CMD ["/root/domoticz/domoticz", "-www", "8080"]
