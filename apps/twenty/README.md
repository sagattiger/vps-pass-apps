# Twenty

Modern open-source CRM (Salesforce alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Twenty` |
| Slug | `twenty` |
| Category | `Business` |
| Description | `Modern open-source CRM (Salesforce alternative)` |
| Web service | `server` |
| Web port | `3000` |
| RAM reserved (MB) | `1536` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and sign up: the first account creates the workspace.
```

## Image tags

`twentycrm/twenty:latest` (server and worker use the same image; version tags exist), `postgres:16-alpine`, `redis:7-alpine` with `noeviction` as upstream requires.

## First login

1. Open the address and sign up: the first account creates the workspace.
2. Import contacts and companies (CSV), connect email/calendar if wanted.

## Admin checks

- The server runs the migrations; the worker has migrations and cron registration turned off, as upstream does.
- Files are stored locally (`STORAGE_TYPE: local`).
- Sign-up stays open; to restrict it, invite users and check Twenty's settings for disabling public sign-up.
- Gmail/Outlook sync needs Google/Microsoft OAuth apps (`AUTH_GOOGLE_*`, `AUTH_MICROSOFT_*`).

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
