# Chatwoot

Customer support inbox. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Chatwoot` |
| Slug | `chatwoot` |
| Category | `Support` |
| Description | `Customer support inbox` |
| Web service | `rails` |
| Web port | `3000` |
| RAM reserved (MB) | `2048` |
| Disk reserved (MB) | `4096` |
| Free from | **Q3** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
$COMPOSE up -d postgres redis
sleep 15
$COMPOSE run --rm rails bundle exec rails db:chatwoot_prepare
```

## Login info

```
Open the address and create the admin account.
```

## Image tags

`chatwoot/chatwoot:latest` (rails + sidekiq), `pgvector/pgvector:pg16` (Chatwoot needs the pgvector extension), `redis:7-alpine`. Chatwoot publishes version tags (`v4.x.y`): pin once tested.

## First login

1. Open the address.
2. Create the admin account on the first page (public sign-up is off: `ENABLE_ACCOUNT_SIGNUP: "false"`).
3. Invite agents from Settings → Agents.

## Admin checks

- **Needs SMTP** for agent invites, password resets and email channels. Add `SMTP_ADDRESS`, `SMTP_PORT`, `SMTP_USERNAME`, `SMTP_PASSWORD`, `MAILER_SENDER_EMAIL` to the shared env block, or tell the customer to set them.
- The run-once command creates the database; without it the app fails on the first start.
- Files are stored locally in the `storage` volume.
- `DEFAULT_LOCALE: pt_BR`.

## Paid products

Needs a **Q1 price** and a (cheaper) **Q2 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q3. Price not set yet.
