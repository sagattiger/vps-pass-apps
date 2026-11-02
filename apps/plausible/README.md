# Plausible

Privacy-friendly website analytics (Google Analytics alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Plausible` |
| Slug | `plausible` |
| Category | `Analytics` |
| Description | `Privacy-friendly website analytics (Google Analytics alternative)` |
| Web service | `plausible` |
| Web port | `8000` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
if [ ! -f app.env ]; then
  printf 'TOTP_VAULT_KEY=%s\n' "$(head -c 32 /dev/urandom | base64 | tr -d '\n')" > app.env
fi
```

## Login info

```
Open the address right away and register: the first account owns the instance.
Then add your site and paste the script into its <head>.
```

## Image tags

`ghcr.io/plausible/community-edition:v3.2.1`, `postgres:16-alpine`, `clickhouse/clickhouse-server:24.12-alpine`: the versions of Plausible's own CE compose.

## First login

1. Open the address **right away** and register: the first account owns the instance.
2. Then set `DISABLE_REGISTRATION: invite_only` in the template and retry the app, so others can join only by invitation.
3. Add the site and put the script tag in its `<head>`.

## Admin checks

- **ClickHouse config:** upstream bind-mounts four small XML files (quieter logs, IPv4 listen, low-resource limits). Templates can't mount files, so ClickHouse's entrypoint is wrapped to write them at every start, then runs the normal `/entrypoint.sh`.
- **Run once** writes `TOTP_VAULT_KEY` (base64 of 32 random bytes, which no placeholder gives) into `app.env`; it encrypts 2FA secrets.
- The Plausible command creates and migrates the database at every start, as upstream does.
- RAM ~600 MB idle (upstream asks for 2 GB on the machine); Umami is the lighter Q1 alternative.
- Email (reports, password reset) needs `MAILER_EMAIL` and `SMTP_*`.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
