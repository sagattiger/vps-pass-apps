# Wiki.js

Modern wiki. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Wiki.js` |
| Slug | `wiki-js` |
| Category | `Documents & Notes` |
| Description | `Modern wiki` |
| Web service | `wiki` |
| Web port | `3000` |
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
Open the address, create the administrator account and keep the site URL {{url}}.
```

## Image tags

`ghcr.io/requarks/wiki:2` (major pin; Wiki.js 2 is the stable line), `postgres:15-alpine`.

## First login

1. Open the address right after the install (the setup page creates the admin).
2. Create the administrator account and keep the site URL `{{url}}`.

## Admin checks

- Email (password reset) needs SMTP, set in Administration → Mail.

## Paid products

None: free in every plan.
