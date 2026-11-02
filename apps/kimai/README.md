# Kimai

Time tracking and timesheets. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Kimai` |
| Slug | `kimai` |
| Category | `Business` |
| Description | `Time tracking and timesheets` |
| Web service | `kimai` |
| Web port | `8001` |
| RAM reserved (MB) | `384` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Email: {{email}}
Password: {{password}}
```

## Image tags

`kimai/kimai2:apache` (official, Apache + PHP in one image), `mariadb:11.4`.

## First login

1. Log in with the customer's email and the password from the login info.
2. Create customers, projects and activities, then start tracking time.

## Admin checks

- The admin is created from `ADMINMAIL`/`ADMINPASS` on the first start.
- `TRUSTED_HOSTS` is the app's host (Kimai rejects other Host headers); `TRUSTED_PROXIES: REMOTE_ADDR` trusts the VM's Traefik so HTTPS links work.
- Upstream uses MySQL 8.3; MariaDB 11.4 is also supported (`serverVersion` set accordingly in `DATABASE_URL`).
- Email (password reset, invoices by mail) needs `MAILER_URL`.

## Paid products

None: free in every plan.
