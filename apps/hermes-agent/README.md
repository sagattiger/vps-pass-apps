# Hermes Agent

Self-hosted AI agent (Nous Research). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Hermes Agent` |
| Slug | `hermes-agent` |
| Category | `AI` |
| Description | `Self-hosted AI agent (Nous Research)` |
| Web service | `hermes` |
| Web port | `9119` |
| RAM reserved (MB) | `1536` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** (Q1 price R$ 6,99/month) |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Dashboard login
User: admin
Password: {{password}}
Add your AI provider key in Config.
```

## Image tags

`nousresearch/hermes-agent:stable` (the project's stable channel; `X.Y.Z` tags exist for an exact pin).

## First login

1. Open the address and sign in as `admin` with the password from the login info.
2. In **Config**, add your AI provider key (OpenRouter, Anthropic, OpenAI, Nous Portal…) and pick a model.
3. Optional: connect Telegram, Discord or other chat platforms in Config.

## Admin checks

- The dashboard refuses to start without a login, so basic auth is set (`HERMES_DASHBOARD_BASIC_AUTH_*`). Hermes says basic auth isn't meant for direct public exposure: here TLS ends at Zoraxy, so the password never travels in clear text, but it's still a single shared password.
- **Behind proxies:** if the dashboard misbehaves (wrong links, login loop), set `dashboard.public_url: {{url}}` and `dashboard.trusted_proxies` (the Docker subnet, e.g. `172.18.0.0/16`) in `/opt/data/config.yaml`. Hermes rejects wildcard and unbounded ranges.
- The OpenAI-compatible API (port 8642) is not exposed: VPS Pass gives one address per app, and it goes to the dashboard.
- 1 GB minimum, 2 GB+ when browser tools are used (`shm_size: 1gb` is set for Chromium).

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Q1 price: **R$ 6,99/month**.
