
# Run expressvpn in a container

FROM debian:bullseye-slim

LABEL maintainer="benjamin@polkaned.net"

ENV ACTIVATION_CODE Code
ENV LOCATION smart
ARG APP=expressvpn_3.36.0.2-1_amd64.deb

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
        /etc/privoxy/config

COPY entrypoint.sh /tmp/entrypoint.sh
COPY expressvpnActivate.sh /tmp/expressvpnActivate.sh

ENTRYPOINT ["/bin/bash", "/tmp/entrypoint.sh"]
