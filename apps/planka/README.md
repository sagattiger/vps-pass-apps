# Planka

Kanban boards (Trello alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Planka` |
| Slug | `planka` |
| Category | `Productivity` |
| Description | `Kanban boards (Trello alternative)` |
| Web service | `planka` |
| Web port | `1337` |
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
User: admin
Password: {{password}}
```

## Image tags

`ghcr.io/plankanban/planka:latest` (v2 line; version tags exist), `postgres:16-alpine`.

## First login

1. Log in with the email or username `admin` and the password from the login info.
2. Create a project and invite users from the admin settings.

## Admin checks

- The admin account is created from `DEFAULT_ADMIN_*`; the email is the customer's.
- `TRUST_PROXY` is on so Planka builds HTTPS links behind the proxies; real-time updates use WebSockets.
- Email notifications need SMTP (`SMTP_*` variables).

## Paid products

None: free in every plan.
