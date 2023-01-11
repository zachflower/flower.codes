---
layout: post
title: "Deploying a Gopher Hole to Fly.io"
date: 9999-01-01 12:00:00
---

```dockerfile
FROM joshkaiju/gophernicus:latest as gophernicus
COPY ./gopher/ /var/gopher/
```

```toml
app = "banana-wool-emergency"
kill_signal = "SIGINT"
kill_timeout = 5
processes = []

[env]
  DISABLE_FOOTER = 1
  DISABLE_HEADER = 1
  HOSTNAME = "banana-wool-emergency.fly.dev"

[experimental]
  allowed_public_ports = []
  auto_rollback = true

[[services]]
  http_checks = []
  internal_port = 70
  processes = ["app"]
  protocol = "tcp"
  script_checks = []
  [services.concurrency]
    hard_limit = 25
    soft_limit = 20
    type = "connections"

  [[services.ports]]
    port = 70

  [[services.tcp_checks]]
    grace_period = "1s"
    interval = "15s"
    restart_limit = 0
    timeout = "2s"
```

```dockerfile
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
```

```conf
[supervisord]
logfile=/dev/stdout
logfile_maxbytes=0
loglevel=info
pidfile=/tmp/supervisord.pid
nodaemon=true
user=root

[program:gophernicus]
command=/gophernicus.sh

[program:gostatic]
command=/goStatic
```

```toml
app = "banana-wool-emergency"
kill_signal = "SIGINT"
kill_timeout = 5
processes = []

[env]
  DISABLE_FOOTER = 1
  DISABLE_HEADER = 1
  HOSTNAME = "banana-wool-emergency.fly.dev"

[experimental]
  allowed_public_ports = []
  auto_rollback = true

[[services]]
  http_checks = []
  internal_port = 8043
  processes = ["app"]
  protocol = "tcp"
  script_checks = []
  [services.concurrency]
    hard_limit = 25
    soft_limit = 20
    type = "connections"

  [[services.ports]]
    force_https = true
    handlers = ["http"]
    port = 80

  [[services.ports]]
    handlers = ["tls", "http"]
    port = 443

  [[services.tcp_checks]]
    grace_period = "1s"
    interval = "15s"
    restart_limit = 0
    timeout = "2s"

[[services]]
  http_checks = []
  internal_port = 70
  processes = ["app"]
  protocol = "tcp"
  script_checks = []
  [services.concurrency]
    hard_limit = 25
    soft_limit = 20
    type = "connections"

  [[services.ports]]
    port = 70

  [[services.tcp_checks]]
    grace_period = "1s"
    interval = "15s"
    restart_limit = 0
    timeout = "2s"
```