# Gotify

Self-hosted push notification server. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Gotify` |
| Slug | `gotify` |
| Category | `Notifications` |
| Description | `Self-hosted push notification server` |
| Web service | `gotify` |
| Web port | `80` |
| RAM reserved (MB) | `64` |
| Disk reserved (MB) | `256` |
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
Android app: server {{url}}
```

## Image tags

`gotify/server:latest` (official; version tags exist).

## First login

1. Log in as `admin` with the password from the login info.
2. Apps → Create application → copy its token.
3. Send: `curl "{{url}}/message?token=<token>" -F title=Hi -F message=Test`.
4. Android app (F-Droid/Play): server `{{url}}`.

## Admin checks

- The admin is created from `GOTIFY_DEFAULTUSER_*` on the first start only.
- The Android app keeps a WebSocket open to the server; it goes through the proxies. There's no official iOS app (ntfy covers iOS).

## Paid products

None: free in every plan.
