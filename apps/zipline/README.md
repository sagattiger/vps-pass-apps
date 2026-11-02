# Zipline

File, image and screenshot sharing (ShareX compatible). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Zipline` |
| Slug | `zipline` |
| Category | `Files` |
| Description | `File, image and screenshot sharing (ShareX compatible)` |
| Web service | `zipline` |
| Web port | `3000` |
| RAM reserved (MB) | `384` |
| Disk reserved (MB) | `5120` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address right away and create the admin account in the setup page.
```

## Image tags

`ghcr.io/diced/zipline:latest` (v4; official), `postgres:16-alpine`.

## First login

1. Open the address **right away** and create the admin in the setup page (first visitor sets it up).
2. Upload from the web, or download the ShareX/Flameshot config from your user settings.

## Admin checks

- **CPU with AVX required:** Zipline v4 publishes no non-AVX build. Proxmox's default VM CPU type `x86-64-v2-AES` has **no AVX**; the VM needs `host` or `x86-64-v3`. Check the VPS Pass VM CPU type before marking it Stable, or it will crash on start.
- Uploads go through Zoraxy; big files need a matching body-size limit.
- **Disk:** uploads grow; 5 GB reserved is a start.

## Paid products

None: free in every plan.
