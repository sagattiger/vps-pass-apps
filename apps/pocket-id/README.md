# Pocket ID

Simple OIDC login provider with passkeys. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Pocket ID` |
| Slug | `pocket-id` |
| Category | `Security` |
| Description | `Simple OIDC login provider with passkeys` |
| Web service | `pocket-id` |
| Web port | `1411` |
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
Open {{url}}/setup right away and register the admin with a passkey.
```

## Image tags

`ghcr.io/pocket-id/pocket-id:latest` (official; version tags exist).

## First login

1. Open `{{url}}/setup` **right away** and create the admin with a passkey (the first visitor sets it up).
2. Add OIDC clients for the apps that support it (Grafana, Mealie, Paperless, Immich, Vaultwarden SSO…), with redirect URLs from each app's docs.

## Admin checks

- **Passkeys are bound to the domain** in `APP_URL`; if the app's address ever changes, existing passkeys stop working.
- `ENCRYPTION_KEY` (40 chars) encrypts stored keys; it must stay the same.
- `TRUST_PROXY` lists the Docker private ranges so Pocket ID sees the real client IP from the VM's Traefik.
- Email (login codes, notifications) needs `SMTP_*`.

## Paid products

None: free in every plan.
