# FreshRSS

RSS and news reader. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `FreshRSS` |
| Slug | `freshrss` |
| Category | `News` |
| Description | `RSS and news reader` |
| Web service | `freshrss` |
| Web port | `80` |
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
Mobile apps (API): {{url}}/api/greader.php, user admin, API password {{secret2}}
```

## Image tags

`freshrss/freshrss:1` (major pin; the official image).

## First login

1. Log in as `admin` with the password from the login info.
2. Add feeds, or import an OPML file.
3. Mobile apps (Reeder, NetNewsWire, FeedMe…): Google Reader API at `{{url}}/api/greader.php`, user `admin`, the **API password** from the login info.

## Admin checks

- Installed automatically on the first start (`FRESHRSS_INSTALL` and `FRESHRSS_USER`, SQLite). These only run once; later changes are made in the app.
- Feeds refresh every 20 minutes (`CRON_MIN`).
- `TRUSTED_PROXY` covers the Docker private ranges so FreshRSS sees HTTPS and the client IP.

## Paid products

None: free in every plan.
