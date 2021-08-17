# ExpressVPN in a container

This container should be used as base layer.

## Prerequisites

1. Get your activation code from ExpressVPN web site.

## Start the container

    docker run \
      --env=ACTIVATION_CODE={% your-activation-code %} \
      --env=SERVER={% LOCATION/ALIAS/COUNTRY %} \
      --cap-add=NET_ADMIN \
      --device=/dev/net/tun \
      --privileged \
      --detach=true \
      --tty=true \
      -p 9050:9050 \
      -p 9052:9052 \
      -p 8118:8118 \
      --name=expressvpn \
      polkaned/privoxy-tor-expressvpn \
      /bin/bash


## Docker Compose
Other containers can use the network of the expressvpn container by declaring the entry `network_mode: service:expressvpn`.
In this case all traffic is routed via the vpn container. To reach the other containers locally the port forwarding must be done in the vpn container (the network mode service does not allow a port configuration)

  ```
  expressvpn:
    container_name: expressvpn
    image: polkaned/privoxy-tor-expressvpn:latest
    privileged: true
    restart: always
    environment:
      - ACTIVATION_CODE={% your-activation-code %}
      - SERVER={% LOCATION/ALIAS/COUNTRY %}
    cap_add:
      - NET_ADMIN
    devices:
      - /dev/net/tun
    ports:
      - 9050:9050
      - 9052:9052
      - 8118:8118
    tty: true
    stdin_open: true
    command: /bin/bash

   downloader:
     image: example/downloader
     container_name: downloader
     network_mode: service:expressvpn
     depends_on:
       - expressvpn
  ```

## Configuration Reference

### ACTIVATION_CODE
A mandatory string containing your ExpressVPN activation code.

`ACTIVATION_CODE=ABCD1EFGH2IJKL3MNOP4QRS`

### SERVER
A optional string containing the ExpressVPN server LOCATION/ALIAS/COUNTRY. Connect to smart location if it is not set.

`SERVER=ukbe`
