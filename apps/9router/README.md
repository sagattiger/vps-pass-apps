# 9Router

AI gateway: one endpoint for Claude Code, Codex, Cursor and 40+ providers. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `9Router` |
| Slug | `9router` |
| Category | `AI` |
| Description | `AI gateway: one endpoint for Claude Code, Codex, Cursor and 40+ providers` |
| Web service | `9router` |
| Web port | `20128` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `1536` |
| Free from | **Q2** (Q1 price R$ 3,99/month) |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Dashboard password: {{password}}
API base URL: {{url}}/v1 (create a key under Endpoint & Key)
```

## Image tags

`decolua/9router:latest` (the official image, also mirrored at `ghcr.io/decolua/9router`). Upstream recommends pinning a version tag of `0.4.45` or newer once tested; `latest` is used until a version has been checked on a real VPS Pass.

## First login

1. Open the address and log in with the dashboard password from the login info (the login page may say *no password is set*; the password still works). Change it under **Settings**.
2. **Providers**: add your provider keys or subscriptions.
3. **Endpoint & Key → Create Key**, then point Claude Code / Codex / Cursor at `{{url}}/v1` with that key. Test with `curl -H "Authorization: Bearer <key>" {{url}}/v1/models`.

## Admin checks

- `REQUIRE_API_KEY: true`: `/v1/*` refuses calls without a dashboard-issued key, so the public address can't be used as an open proxy on the customer's provider accounts.
- `INITIAL_PASSWORD` only seeds the first login; `JWT_SECRET` and `API_KEY_SECRET` must stay the same (sessions and issued keys).
- `ENABLE_REQUEST_LOGS: false`: full request/response bodies aren't written to disk (privacy, disk use).
- SQLite and backups live in the `data` volume (`/app/data/db`).
- OmniRoute is a fork of 9Router with more features; both are in the catalogue at the same price.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Q1 price: **R$ 3,99/month**.
