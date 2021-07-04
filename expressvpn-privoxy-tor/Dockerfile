
# Run expressvpn in a container

FROM debian:bullseye-slim

LABEL maintainer="benjamin@polkaned.net"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ARG APP=expressvpn_3.9.0.75-1_amd64.deb
ARG SPEEDTEST_INSTALL_KEY=379CE192D401AB61

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget curl apt-utils apt-transport-https dirmngr ca-certificates expect iproute2 procps libnm0 gnupg2 tor privoxy \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q "https://www.expressvpn.works/clients/linux/${APP}" -O /tmp/${APP} \
    && dpkg -i /tmp/${APP} \
    && rm -rf /tmp/*.deb \
    && apt-get purge -y --auto-remove wget \
    && sed -i \
        -e 's/#SocksPort 192.168.0.1:9100/SocksPort 0.0.0.0:9050/g' \
        -e 's/#ControlPort 9051/ControlPort 9052/g' \
        /etc/tor/torrc \
    && sed -i \
        -e 's/listen-address\s*127.0.0.1:8118/listen-address 0.0.0.0:8118/g' \
        /etc/privoxy/config \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${SPEEDTEST_INSTALL_KEY} \
    && touch /etc/apt/sources.list.d/speedtest.list \
    && echo "deb https://ookla.bintray.com/debian generic main" > /etc/apt/sources.list.d/speedtest.list \
    && apt-get update && apt-get install -y --no-install-recommends speedtest

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
