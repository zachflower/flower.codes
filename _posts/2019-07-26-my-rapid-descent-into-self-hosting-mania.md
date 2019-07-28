---
layout: post
title:  "My Rapid Descent into Self-Hosting Mania"
date:   2019-07-26 10:53:00
categories: [projects]
---

## It All Starts with a Server

### Different Servers for Different Purposes

#### At Home

In mid-2012 I bought a Mac Mini in an ill-advised impulse buy, and while I used it for a (very) short period of time as a dedicated Plex server, it has spent most of its life in my basement collecting dust.

- Home Assistant
- Plex
- Orbi
- Tautulli
- Beets
- Private WoW Server

#### In the Cloud

Everyone loves [DigitalOcean](https://m.do.co/c/a8eb87aea1f2).

- Gitea
- Drone
- Docker Registry
- MUD Server
- Mail Server

### Security 101

#### Firewalls

Conventional wisdom states that you should only have _one_ firewall.

#### SSH

```
sudo apt-get install fail2ban
```

#### Remote Access

ZeroTier.

## The Tools of the Trade

### Docker

#### Your Friend, Docker Compose

#### Y U No Swarm?

#### Scaffolding

### Portainer

```sh
docker volume create portainer_data
```

```yaml
version: '2'
services:
  portainer:
    image: portainer/portainer:latest
    volumes:
      - portainer_data:/data
      - /var/run/docker.sock:/var/run/docker.sock
    restart: always
    ports:
      - "9000:9000"
volumes:
  portainer_data:
    external:
      name: portainer_data
```

### Traefik

```toml
# Entrypoint configuration when using ACME.
[entryPoints]
  [entryPoints.http]
  address = ":80"
    [entryPoints.http.redirect]
      entryPoint = "https"
  [entryPoints.https]
  address = ":443"
    [entryPoints.https.tls]

# Enable ACME (Let's Encrypt): automatic SSL.
[acme]

# Email address used for registration.
email = "you@example.com"

# File or key used for certificates storage.
storage = "acme.json"

# Entrypoint to proxy acme apply certificates to.
entryPoint = "https"

# Use a TLS-ALPN-01 ACME challenge.
[acme.tlsChallenge]

# Use a DNS-01 ACME challenge rather than HTTP-01 challenge.
# Note: mandatory for wildcard certificate generation.
[acme.dnsChallenge]

  # DNS provider used.
  provider = "digitalocean"

# Domains list.
# Only domains defined here can generate wildcard certificates.
# The certificates for these domains are negotiated at traefik startup only.
[[acme.domains]]
  main = "*.example.com"
[[acme.domains]]
  main = "example.com"

# API definition
[api]

# Disable Dashboard
dashboard = false

# Enable Docker Provider.
[docker]

# Watch for docker changes.
watch = true

# Define a default docker network to use for connections to all containers.
# Can be overridden by the traefik.docker.network label.
network = "web"
```

```sh
mkdir /opt/traefik
touch /opt/traefik/acme.json
chmod 600 /opt/traefik/acme.json
```

```sh
docker network create web
```

```yaml
version: '2'
services:
  traefik:
    image: traefik:latest
    restart: always
    environment:
      DO_AUTH_TOKEN: INSERT_DIGITALOCEAN_AUTH_TOKEN_HERE
    ports:
      - 80:80
      - 443:443
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /opt/traefik/acme.json:/acme.json
      - /opt/traefik/traefik.toml:/etc/traefik/traefik.toml
    networks:
      - web
    logging:
      driver: json-file
networks:
  web:
    external:
      name: web
```

```yaml
version: '2'
services:
  portainer:
    image: portainer/portainer:latest
    volumes:
      - portainer_data:/data
      - /var/run/docker.sock:/var/run/docker.sock
    restart: always
    networks:
      - web
    labels:
      traefik.enable: 'true'
      traefik.frontend.rule: Host:portainer.flower.codes
      traefik.port: '9000'
      traefik.webservice.frontend.entryPoints: https
networks:
  web:
    external:
      name: web
volumes:
  portainer_data:
    external:
      name: portainer_data
```

### Updates

#### Patch Your Shit

#### All Along the Watchtower

```sh
docker ps
```

```yaml
version: "2"
services:
  watchtower:
    image: v2tec/watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: container_name_1 container_name_2 container_name_3
```

## What's Next?

### Monitoring

- Grafana
- Prometheus

### ZeroTier => VPN

- You can only trust ZeroTier so far... it's a start, but it's not the end-game
- OpenVPN is popular, but I've never been a fan of its usability
- What other options are out there?

### Container Scanning

- snyk.io

### Registry Interface

- r.j3ss.co

### Notifications

- Push, email, or SMS?

### Better Backups

- DigitalOcean is a start
- More targeted backups would be nice

### Secrets, Secrets, Secrets

- Utilize Docker secrets for better information security

### Additional Authentication Support

- What to do about services that don't offer two-factor authentication?
- What about single sign-on?
- Can Traefik's forward authentication help?

## Resources

- https://www.reddit.com/r/selfhosted/
- https://geek-cookbook.funkypenguin.co.nz/
- https://github.com/Kickball/awesome-selfhosted