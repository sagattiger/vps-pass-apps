# Gitea

Git hosting. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Gitea` |
| Slug | `gitea` |
| Category | `Developer` |
| Description | `Git hosting` |
| Web service | `gitea` |
| Web port | `3000` |
| RAM reserved (MB) | `384` |
| Disk reserved (MB) | `2048` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address, keep the suggested settings (SQLite) and create the administrator account at the bottom of the page.
```

## Image tags

`gitea/gitea:latest`. Gitea also publishes version tags (e.g. `1.24`): pin to a minor once tested.

## First login

1. Open the address right after the install (whoever opens the install page first sets it up).
2. Keep the suggested settings (SQLite).
3. Create the administrator account at the bottom of the page.

## Admin checks

- **No SSH:** VPS Pass routes HTTP only, so `git clone` works over HTTPS, not SSH. Possible improvement: add `GITEA__server__DISABLE_SSH: "true"` so Gitea stops showing SSH clone URLs.
- Email (registration, notifications) needs SMTP, set by the customer in the admin panel or `app.ini`.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3.
