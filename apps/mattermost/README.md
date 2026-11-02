# Mattermost

Team chat (Slack alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Mattermost` |
| Slug | `mattermost` |
| Category | `Business` |
| Description | `Team chat (Slack alternative)` |
| Web service | `mattermost` |
| Web port | `8065` |
| RAM reserved (MB) | `768` |
| Disk reserved (MB) | `3072` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and create your account: the first account is the system admin.
Desktop and mobile apps: server {{url}}
```

## Image tags

`mattermost/mattermost-team-edition:latest` (the free Team Edition; pin a version tag once tested), `postgres:16-alpine`.

## First login

1. Open the address and create your account: the first account is the system admin.
2. Create a team and invite people.
3. Desktop and mobile apps: server `{{url}}`.

## Admin checks

- `MM_SERVICESETTINGS_SITEURL` is the public HTTPS address (needed for links and the mobile apps); WebSockets go through the proxies.
- **Calls (voice/video) won't work**: the Calls plugin needs UDP 8443, and VPS Pass routes HTTP only. Text, files and integrations work.
- The volumes start from the image folders, so they keep Mattermost's user (UID 2000) without a run-once step.
- Push notifications to phones use Mattermost's public proxy (TPNS) by default; email needs SMTP in the System Console.

## Paid products

None: free in every plan.
