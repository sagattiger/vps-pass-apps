# Homarr

Homepage dashboard for your apps. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Homarr` |
| Slug | `homarr` |
| Category | `Dashboard` |
| Description | `Homepage dashboard for your apps` |
| Web service | `homarr` |
| Web port | `7575` |
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
Open the address and follow the onboarding to create the admin account.
```

## Image tags

`ghcr.io/homarr-labs/homarr:latest` (version tags exist: pin once tested).

## First login

1. Open the address and follow the onboarding.
2. Create the admin account and start adding your apps.

## Admin checks

- No Docker socket is mounted (template rule), so Homarr's Docker integration (container list, start/stop) isn't available. Links, widgets and app integrations over HTTP work.
- `SECRET_ENCRYPTION_KEY` (64 hex chars) encrypts saved integration secrets: it must never change.

## Paid products

None: free in every plan.
