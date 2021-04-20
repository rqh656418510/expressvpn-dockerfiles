#!/bin/bash

echo ""
echo "~> Build script for expressvpn container"
echo ""

echo "~> Get the expressvpn version..."
expressvpn_version="$(grep 'ARG APP' Dockerfile | cut -d"_" -f2)"
echo "${expressvpn_version}"
echo ""

echo "~> Get the container tag..."
tag=${expressvpn_version}
echo "${tag}"
echo ""

echo "~> Build the image..."
docker build --pull --no-cache --rm --force-rm -f Dockerfile -t polkaned/privoxy-tor-expressvpn:latest .
echo ""
