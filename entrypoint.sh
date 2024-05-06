#!/bin/sh

if [ ! -c /dev/net/tun ]; then
  if [ ! -d /dev/net ]; then
    mkdir -m 755 /dev/net
  fi
  mknod /dev/net/tun c 10 200
  chmod 0755 /dev/net/tun
fi

openvpn --config /etc/openvpn/client/vpn.ovpn &

wait $!

exec "$@"
