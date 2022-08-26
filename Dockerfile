FROM joshkaiju/gophernicus:latest as gophernicus
FROM pierrezemb/gostatic:latest as gostatic
FROM alpine:latest

RUN apk update && apk add --no-cache supervisor

RUN mkdir -p /etc/xinetd.d/

COPY --from=gophernicus /usr/sbin/xinetd /usr/sbin
COPY --from=gophernicus /usr/sbin/gophernicus /usr/sbin
COPY --from=gophernicus /etc/xinetd.conf /etc
COPY --from=gophernicus /init.sh /gophernicus.sh

COPY --from=gostatic /goStatic /

COPY ./_gopher/ /var/gopher/
COPY ./_http/ /srv/http/

COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]