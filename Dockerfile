FROM alpine:latest

RUN apk update && \
    apk add --no-cache iputils curl openvpn netcat-openbsd && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /etc/openvpn/client/
RUN chmod -R 755 /etc/openvpn/client/

ARG METHOD
ARG HOST
ARG PORT
ARG PROTOCOL
ARG USERNAME

ENV HOST=$HOST
ENV PORT=$PORT
ENV PROTOCOL=$PROTOCOL
ENV USERNAME=$USERNAME
ENV METHOD=$METHOD

COPY ./entrypoint.sh /etc/openvpn/clients/entrypoint.sh

WORKDIR /etc/openvpn/clients

RUN ls /etc/openvpn/client/

ENTRYPOINT ["/etc/openvpn/clients/entrypoint.sh"]

CMD ["/bin/sh"]
