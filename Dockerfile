FROM alpine:latest

RUN apk update && \
    apk add --no-cache iputils curl openvpn && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /etc/openvpn/client/
RUN chmod -R 755 /etc/openvpn/client/

COPY ./entrypoint.sh /etc/openvpn/clients/entrypoint.sh

WORKDIR /etc/openvpn/clients

RUN ls /etc/openvpn/client/

ENTRYPOINT ["/etc/openvpn/clients/entrypoint.sh"]

CMD ["/bin/sh"]
