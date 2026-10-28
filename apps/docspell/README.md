# Docspell

Document organizer with OCR and auto-tagging. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Docspell` |
| Slug | `docspell` |
| Category | `Documents & Notes` |
| Description | `Document organizer with OCR and auto-tagging` |
| Web service | `restserver` |
| Web port | `7880` |
| RAM reserved (MB) | `2560` |
| Disk reserved (MB) | `5120` |
| Free from | **Q3** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Sign-up needs an invite:
1. Open {{url}}/app/newinvite and enter the password {{secret2}} to create an invite key.
2. Open {{url}}/app/register, use the same name for collective and user, and paste the invite key.
```

## Image tags

`ghcr.io/docspell/restserver:v0.43.0` and `ghcr.io/docspell/joex:v0.43.0` (pinned, server and worker must match), `postgres:16-alpine`, `solr:9` for full-text search.

## First login

1. Open `{{url}}/app/newinvite`, enter the invite password from the login info and create an invite key.
2. Open `{{url}}/app/register`, use the same name for collective and user, paste the invite key.
3. Upload documents in the web app; OCR and tagging run in the background (joex).

## Admin checks

- **Heavy:** Java server + Java worker (1 GB heap) + Solr + OCR tools, about 2.5 GB, so it's free only from Q3 (paid in Q1 and Q2). Upstream recommends 4 GB+ for the machine.
- Sign-up is **invite only**; the invite password is `{{secret2}}`, so only the customer can make accounts.
- `AUTH_SERVER__SECRET` is fixed (`hex:{{hex64}}`), so logins survive restarts.
- The upstream *consumedir* (watch a folder) service is left out: it needs a host folder. Documents come in through the web upload, the apps or email (set in the app).
- Solr's heap is capped at 384 MB (`SOLR_HEAP`); raise it for very large archives.

## Paid products

Needs a **Q1 price** and a (cheaper) **Q2 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q3. Price not set yet.
