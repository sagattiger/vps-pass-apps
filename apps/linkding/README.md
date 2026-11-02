# Linkding

Bookmark manager. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Linkding` |
| Slug | `linkding` |
| Category | `Productivity` |
| Description | `Bookmark manager` |
| Web service | `linkding` |
| Web port | `9090` |
| RAM reserved (MB) | `128` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
User: admin
Password: {{password}}
Browser extension: server {{url}} plus the API token from Settings > Integrations
```

## Image tags

`sissbruecker/linkding:latest` (official; `latest-plus` adds archiving with Chromium and needs more RAM).

## First login

1. Log in as `admin` with the password from the login info.
2. Install the browser extension (Firefox/Chrome) or the bookmarklet.

## Admin checks

- The admin is created from `LD_SUPERUSER_*` on the first start.
- `LD_CSRF_TRUSTED_ORIGINS` is the public HTTPS address; without it logins fail with a CSRF error behind the proxies.

## Paid products

None: free in every plan.
