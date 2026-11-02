# Snipe-IT

IT asset and license management. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Snipe-IT` |
| Slug | `snipe-it` |
| Category | `Business` |
| Description | `IT asset and license management` |
| Web service | `snipeit` |
| Web port | `80` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `2048` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Paste [`setup.sh`](setup.sh) into **Run once before the first start**:

```sh
printf 'APP_KEY=base64:%s\n' "$(head -c 32 /dev/urandom | base64)" > app.env
```

## Login info

```
Open the address right away: the setup wizard checks the system and creates the admin account.
```

## Image tags

`snipe/snipe-it:latest` (the only supported image; upstream recommends pinning a version tag such as `v8.x.y` once tested), `mariadb:11.4`.

## First login

1. Open the address right away: the setup wizard checks the system, then creates the admin account (whoever opens it first sets it up).
2. Settings: company, currency, asset tags.

## Admin checks

- **Run once** writes the Laravel `APP_KEY` into `app.env` (same as InvoiceShelf).
- `APP_TRUSTED_PROXIES` (Docker private ranges) and `SECURE_COOKIES` are set for the HTTPS proxies.
- Upstream warns that strict SQL mode can break the first migrations on some MySQL/MariaDB setups; if the install fails on a migration, check the app logs.
- Email (checkout notices, alerts) needs `MAIL_*` variables.

## Paid products

None: free in every plan.
