# Activepieces

No-code workflow automation (Zapier alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Activepieces` |
| Slug | `activepieces` |
| Category | `Automation` |
| Description | `No-code workflow automation (Zapier alternative)` |
| Web service | `activepieces` |
| Web port | `80` |
| RAM reserved (MB) | `768` |
| Disk reserved (MB) | `3072` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
if [ ! -f app.env ]; then
  printf 'AP_ENCRYPTION_KEY=%s\n' "$(head -c 16 /dev/urandom | od -An -tx1 | tr -d ' \n')" > app.env
fi
```

## Login info

```
Open the address right away and sign up: the first account is the platform admin.
Webhook URLs use {{url}}
```

## Image tags

`activepieces/activepieces:latest` (official; version tags exist). Single container with the embedded PGlite database and in-memory queue, the setup Activepieces documents for small installs.

## First login

1. Open the address **right away** and sign up: the first account is the platform admin (first visitor sets it up).
2. Build flows from 300+ pieces (WhatsApp/Evolution API via HTTP, Google Sheets, OpenAI, n8n-style webhooks…).

## Admin checks

- **Run once** writes `AP_ENCRYPTION_KEY` (exactly 32 hex characters, which no placeholder gives) into `app.env`. It encrypts saved connections: keep it with the app folder.
- `AP_FRONTEND_URL` is the public HTTPS address, so webhook and OAuth redirect URLs are correct.
- **PGlite + in-memory queue:** light and simple, fine for one customer's flows. Queued runs are lost if the container restarts mid-run; heavy users should move to Postgres + Redis (`AP_DB_TYPE: POSTGRES`, `AP_REDIS_TYPE: STANDALONE`).
- `UNSANDBOXED`: code steps run inside the container (it's the customer's own VM).

## Paid products

None: free in every plan.
