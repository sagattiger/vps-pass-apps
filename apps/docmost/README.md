# Docmost

Collaborative wiki and docs. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Docmost` |
| Slug | `docmost` |
| Category | `Documents & Notes` |
| Description | `Collaborative wiki and docs` |
| Web service | `web` |
| Web port | `8080` |
| RAM reserved (MB) | `528` |
| Disk reserved (MB) | `2048` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and create your workspace and owner account.
```

## Image tags

`docmost/docmost:latest`, `nginx:1-alpine` in front (see Admin checks) (Docmost publishes version tags too: pin one once tested), `postgres:16-alpine`, `redis:7-alpine` (append-only, `noeviction` as Docmost asks).

## First login

1. Open the address.
2. Create the workspace and your account: it becomes the workspace owner.
3. Invite members from Settings → Members.

## Admin checks

- **Why the nginx in front (`web`):** behind Zoraxy, Docmost answered **415 Unsupported Media Type** to its own empty POST requests (`/api/users/me`, `/api/auth/collab-token`, `/api/workspace/entitlements`) and showed a black page after login ([docmost#709](https://github.com/docmost/docmost/issues/709)). Zoraxy forwards an empty body in a way Docmost's server (Fastify) reads as a body of unknown type. nginx buffers the request and sends a clean `Content-Length: 0`, so Docmost accepts it. It also passes the WebSockets for the live editor. Keep **Web service = `web`, port 8080** in the catalogue.
- `APP_SECRET` (40 chars) must stay the same after the install; Docmost refuses to start with a short or default secret.
- The real-time editor uses WebSockets; they pass through Zoraxy and both Traefiks.
- Email invites and password reset need SMTP (`MAIL_DRIVER=smtp`, `SMTP_HOST`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`, `MAIL_FROM_ADDRESS`); without it, invite links can still be copied by hand.
- Files are stored locally in the `storage` volume.

## Paid products

None: free in every plan.
