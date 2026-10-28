# Colanode

Chat, pages and databases (Slack + Notion alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Colanode` |
| Slug | `colanode` |
| Category | `Documents & Notes` |
| Description | `Chat, pages and databases (Slack + Notion alternative)` |
| Web service | `web` |
| Web port | `8080` |
| RAM reserved (MB) | `640` |
| Disk reserved (MB) | `2048` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address, add the server {{url}}/api/config if asked, then register: the first account gets the first workspace.
Desktop app server: {{url}}/api/config
```

## Image tags

`ghcr.io/colanode/server:latest` and `ghcr.io/colanode/web:latest` (the project publishes `latest`), `pgvector/pgvector:pg17`, `valkey/valkey:8`, `nginx:1-alpine` in front.

## First login

1. Open the address. If the app asks for a server, add `{{url}}/api/config`.
2. Click **Register**: the first account gets the first workspace.
3. Desktop app: add the server `{{url}}/api/config`.

## Admin checks

- **One address, two services:** VPS Pass gives one host per app, so the small nginx (`web`) sends `/api/` to the server and everything else to the web client, as in Colanode's own reverse-proxy example. `SERVER_PATH_PREFIX: api` makes the server report the matching URLs. If the web client shows the server as unavailable, this prefix is the first thing to check.
- Real-time sync uses WebSockets on `/api/`; nginx passes the upgrade headers.
- Registration is open (`automatic` verification): anyone with the address can make an account. To restrict it, mount a custom `config.json` (needs a template change; Colanode no longer reads most settings from plain env vars).
- Files are stored in the `storage` volume (`/var/lib/colanode/storage`).

## Paid products

None: free in every plan.
