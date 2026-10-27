# Paperless-ngx

Document management with OCR. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Paperless-ngx` |
| Slug | `paperless-ngx` |
| Category | `Documents & Notes` |
| Description | `Document management with OCR` |
| Web service | `webserver` |
| Web port | `8000` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `4096` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
User: admin
Password: {{secret2}}
```

## Image tags

`ghcr.io/paperless-ngx/paperless-ngx:latest` (version tags exist: pin once tested), `postgres:16-alpine`, `redis:7-alpine`.

## First login

1. Open the address and log in as `admin` with the password from the login info.
2. Upload documents from the web page or the mobile apps; OCR runs in Portuguese + English.

## Admin checks

- One task worker, one thread, one web worker to keep Q1 light; OCR of big PDFs will be slower. Raise `PAPERLESS_TASK_WORKERS` for Q2/Q3-sized customers.
- `PAPERLESS_OCR_LANGUAGES: por` installs the Portuguese OCR pack at every start (needs internet from the VM; adds a few seconds).
- The `consume` folder can't be reached from outside (no host paths), so documents come in through the web/app upload, or by email (set in the admin).

## Paid products

None: free in every plan.
