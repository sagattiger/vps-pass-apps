# AFFiNE

Docs, whiteboards and databases (Notion + Miro alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `AFFiNE` |
| Slug | `affine` |
| Category | `Documents & Notes` |
| Description | `Docs, whiteboards and databases (Notion + Miro alternative)` |
| Web service | `affine` |
| Web port | `3010` |
| RAM reserved (MB) | `1536` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d postgres redis
for i in $(seq 1 30); do
  $COMPOSE exec -T postgres pg_isready -U affine -d affine >/dev/null 2>&1 && break
  sleep 2
done
$COMPOSE run --rm --no-deps -T migration node ./scripts/self-host-predeploy.js
```

## Login info

```
Open the address and create the administrator account (name, email, password) on the first screen.
```

## Image tags

`ghcr.io/toeverything/affine:stable` (the project's stable channel), `pgvector/pgvector:pg16`, `redis:7-alpine`.

## First login

1. Open the address and create the administrator account (name, email, password).
2. Create a workspace of type *AFFiNE Cloud* (self-hosted) so it's stored on the server, not only in the browser.
3. Desktop/mobile apps: add the server `{{url}}`.

## Admin checks

- **Migrations:** the run-once command creates the database before the first start. The `migration` service runs the same migration at every start and then sleeps, so a newer `stable` image migrates itself. It must keep `restart: unless-stopped` like every service; a plain one-shot job would be restarted in a loop.
- `AFFINE_INDEXER_ENABLED: "false"`: no Manticore/Elastic search service (saves ~1 GB); search inside docs still works locally in the app.
- RAM 1.5 GB for server + Postgres + Redis, so it's free from Q2. The upstream guides ask for 2 GB+ on the whole machine.
- Email (invites, magic links) needs SMTP: `MAILER_HOST`, `MAILER_PORT`, `MAILER_USER`, `MAILER_PASSWORD`, `MAILER_SENDER`.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
