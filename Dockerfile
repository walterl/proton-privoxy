FROM alpine:3.11
LABEL maintainer="Walter Leibbrandt"

EXPOSE 8080

ENV PVPN_USERNAME=
ENV PVPN_PASSWORD=
ENV PVPN_TIER=2
ENV PVPN_PROTOCOL=udp
ENV PVPN_CMD_ARGS="connect --fastest"
ENV PVPN_DEBUG=

COPY app /app
COPY pvpn-cli /root/.pvpn-cli

RUN apk --update add coreutils openvpn privoxy procps python3 runit \
	&& pip3 install protonvpn-cli

CMD ["runsvdir", "/app"]
