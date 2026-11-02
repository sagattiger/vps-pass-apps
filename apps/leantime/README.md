# Leantime

Project management for non-project managers. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Leantime` |
| Slug | `leantime` |
| Category | `Business` |
| Description | `Project management for non-project managers` |
| Web service | `leantime` |
| Web port | `8080` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `1536` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address right away: the installer creates the database and your admin account.
```

## Image tags

`leantime/leantime:latest` (official), `mariadb:11.4` (upstream example uses MySQL 8.4; Leantime supports both).

## First login

1. Open the address right away: the installer creates the database tables and your admin account (whoever opens it first sets it up).
2. Create a project and invite your team.

## Admin checks

- `LEAN_SESSION_PASSWORD` is fixed per install; `LEAN_SESSION_SECURE` is on for HTTPS.
- `LEAN_APP_URL` is the public address so links use HTTPS; if Leantime still builds `http://` links, check that this variable is honoured by the installed version.
- Email needs `LEAN_EMAIL_*` SMTP variables.

## Paid products

None: free in every plan.
