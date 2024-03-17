FROM alpine:3.16
LABEL maintainer="Walter Leibbrandt"
LABEL version="0.4.3"
# XXX Copy version to Docker image tag in .github/workflows/docker.yml when changing!

EXPOSE 8080

ARG PVPN_CLI_VER=2.2.12
ENV PVPN_USERNAME= \
    PVPN_USERNAME_FILE= \
    PVPN_PASSWORD= \
    PVPN_PASSWORD_FILE= \
    PVPN_TIER=2 \
    PVPN_PROTOCOL=udp \
    PVPN_CMD_ARGS="connect --fastest" \
    PVPN_DEBUG= \
    HOST_NETWORK= \
    DNS_SERVERS_OVERRIDE=

COPY app /app
COPY pvpn-cli /root/.pvpn-cli

RUN apk --update add coreutils openvpn privoxy procps python3 runit git \
    && python3 -m ensurepip \
    && pip3 install git+https://github.com/Rafficer/linux-cli-community.git@v$PVPN_CLI_VER

CMD ["runsvdir", "/app"]
