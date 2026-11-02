# PocketBase

Backend in one file: database, auth, files and realtime API. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `PocketBase` |
| Slug | `pocketbase` |
| Category | `Developer` |
| Description | `Backend in one file: database, auth, files and realtime API` |
| Web service | `pocketbase` |
| Web port | `8090` |
| RAM reserved (MB) | `64` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Dashboard: {{url}}/_/
Email: {{email}}
Password: {{password}}
```

## Image tags

`ghcr.io/muchobien/pocketbase:latest`: PocketBase publishes binaries, not an official image; this is the most used community image (tags follow PocketBase versions).

## First login

1. Open `{{url}}/_/` and log in with the customer's email and the password from the login info.
2. Create collections; the API is at `{{url}}/api/`.

## Admin checks

- The superuser is created/updated from `PB_ADMIN_*` at every start (`superuser upsert`).
- Front-end files can be served from the `public` volume and JS hooks go in `hooks`; both are copied in from the VM.
- Very light (~30 MB RAM).

## Paid products

None: free in every plan.
