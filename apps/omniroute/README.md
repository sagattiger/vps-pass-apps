# OmniRoute

AI gateway for many model providers. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `OmniRoute` |
| Slug | `omniroute` |
| Category | `AI` |
| Description | `AI gateway for many model providers` |
| Web service | `omniroute` |
| Web port | `20128` |
| RAM reserved (MB) | `768` |
| Disk reserved (MB) | `2048` |
| Free from | **Q2** (Q1 price R$ 3,99/month) |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Dashboard password: {{password}}
API base URL: {{url}}/v1 (create an API key under Endpoints)
```

## Image tags

`diegosouzapw/omniroute:latest` (version tags exist: pin once tested).

## First login

1. Open the address and log in with the dashboard password from the login info, then change it in Settings.
2. Connect providers (free tiers, API keys, subscriptions).
3. Under **Endpoints**, create an API key; clients use `{{url}}/v1` as an OpenAI-compatible base URL.

## Admin checks

- Other secrets (`JWT_SECRET`, `API_KEY_SECRET`, `STORAGE_ENCRYPTION_KEY`) are generated on first boot and kept in `/app/data/server.env` in the volume.
- `stop_grace_period: 40s` lets it checkpoint its SQLite database on shutdown.
- Idles around 540 MB; reserved 768 MB.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Q1 price: **R$ 3,99/month**.
