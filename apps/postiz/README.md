# Postiz

Social media scheduling for 20+ networks. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Postiz` |
| Slug | `postiz` |
| Category | `Marketing` |
| Description | `Social media scheduling for 20+ networks` |
| Web service | `postiz` |
| Web port | `5000` |
| RAM reserved (MB) | `2048` |
| Disk reserved (MB) | `6144` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and register: the first account owns the workspace.
Then connect your social networks (each needs its own API app; see the Postiz docs).
```

## Image tags

`ghcr.io/gitroomhq/postiz-app:latest` (official), `postgres:17-alpine`, `redis:7-alpine`, `temporalio/auto-setup:1.28.1` with its own `postgres:16-alpine`.

## First login

1. Open the address and register: the first account owns the workspace.
2. Add channels: each social network needs its own developer app and keys (X, LinkedIn, Facebook/Instagram, YouTube, TikTok…), set as variables in the template (see the Postiz docs).
3. Then set `DISABLE_REGISTRATION: "true"` and retry the app so nobody else can sign up.

## Admin checks

- **Temporal:** since v2.12 Postiz runs its scheduled jobs on Temporal. The template keeps the upstream Temporal server and its Postgres but leaves out Elasticsearch (`ENABLE_ES: false`, visibility in Postgres), the Temporal UI, admin tools and Spotlight to save ~1 GB of RAM.
- `NEXT_PUBLIC_BACKEND_URL` is `{{url}}/api`: frontend and backend share the one address, as upstream does on port 5000.
- RAM ~2 GB (upstream tests on a 2 GB VM), so it's free from Q2.
- Social API keys are the customer's own; without them no channel can be connected.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
