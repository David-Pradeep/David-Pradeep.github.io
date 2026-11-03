---
title: "Self-hosting a service with Docker Compose"
date: 2026-11-02T18:00:00+05:30
summary: "A minimal, repeatable pattern for running a self-hosted app behind a reverse proxy."
tags: ["docker", "caddy", "homelab"]
categories: ["DevOps"]
---

Docker Compose is the quickest way to run a self-hosted service in a way you can reproduce and back up.

## A minimal stack

```yaml
services:
  app:
    image: ghcr.io/example/app:1.0
    restart: unless-stopped
    volumes:
      - ./data:/data
    networks: [web]

  caddy:
    image: caddy:2
    restart: unless-stopped
    ports: ["80:80", "443:443"]
    volumes:
      - ./Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
    networks: [web]

networks:
  web:

volumes:
  caddy_data:
```

```
app.example.com {
    reverse_proxy app:8080
}
```

## Habits worth keeping

- Pin image versions instead of using `latest`.
- Keep all state in bind-mounted folders so backups are one `rsync` away.
- Keep the compose files in Git, with secrets in an untracked `.env` file.
