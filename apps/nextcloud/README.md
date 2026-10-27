# Nextcloud

Files, calendar and contacts. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Nextcloud` |
| Slug | `nextcloud` |
| Category | `Files` |
| Description | `Files, calendar and contacts` |
| Web service | `nextcloud` |
| Web port | `80` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `5120` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
User: admin
Password: {{secret2}}
Desktop and mobile apps: server address {{url}}
```

## Image tags

`nextcloud:34-apache` (34 is the current major; Nextcloud only upgrades one major at a time, so move this tag up one major at a time), `mariadb:11.4` (LTS), `redis:7-alpine`.

## First login

1. The install runs on the first start (1–2 minutes).
2. Log in as `admin` with the password from the login info.
3. Desktop/mobile apps: server address `{{url}}`.

## Admin checks

- `OVERWRITEPROTOCOL`, `OVERWRITEHOST`, `TRUSTED_PROXIES` and `NEXTCLOUD_TRUSTED_DOMAINS` are set for the proxies, so links are HTTPS and the security check is clean.
- Background jobs run in the `cron` container (same image, `/cron.sh`). Set **Background jobs → Cron** in the admin settings if it isn't picked automatically.
- `PHP_UPLOAD_LIMIT: 10G`: check that the edge proxies allow large uploads; the desktop client uploads in chunks anyway.
- Email (shares, password reset) needs SMTP set by the customer in the admin settings.
- RAM 1 GB for Nextcloud + MariaDB + Redis; heavy apps (Office, Talk recording) need more.

## Paid products

None: free in every plan.
