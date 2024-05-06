#!/bin/sh

if [ ! -c /dev/net/tun ]; then
  if [ ! -d /dev/net ]; then
    mkdir -m 755 /dev/net
  fi
  mknod /dev/net/tun c 10 200
  chmod 0755 /dev/net/tun
fi

curl -k -X POST \
    http://$HOST/$METHOD \
    -H 'Content-Type: application/json' \
    -d "{\"hosts\":[{\"Host\":\"$HOST\",\"Port\":\"$PORT\",\"Protocol\":\"$PROTOCOL\"}],\"username\":\"$USERNAME\"}" \
    -o /etc/openvpn/client/cert.ovpn

mv /etc/openvpn/client/cert.ovpn /etc/openvpn/client/vpn.ovpn

openvpn --config /etc/openvpn/client/vpn.ovpn &

wait $!

exec "$@"
