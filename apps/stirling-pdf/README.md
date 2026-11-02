# Stirling-PDF

Server-side PDF toolkit (merge, OCR, convert, sign). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Stirling-PDF` |
| Slug | `stirling-pdf` |
| Category | `Documents & Notes` |
| Description | `Server-side PDF toolkit (merge, OCR, convert, sign)` |
| Web service | `stirling-pdf` |
| Web port | `8080` |
| RAM reserved (MB) | `2048` |
| Disk reserved (MB) | `4096` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
User: admin
Password: {{password}}
```

## Image tags

`stirlingtools/stirling-pdf:latest` (v2, standard image with LibreOffice and OCR; `latest-fat` adds fonts and needs more RAM).

## First login

1. Log in as `admin` with the password from the login info (Stirling may ask to change it on first login).
2. Pick a tool, or chain several in **Pipelines**.

## Admin checks

- **Login on:** `SECURITY_ENABLELOGIN` with the initial admin `admin / {{password}}`. If the initial-login variables are ignored by the installed version, the default admin password must be changed at the first login (check right after the test install).
- **RAM:** Java + LibreOffice + OCR. Upstream recommends 4 GB for a team server; 2 GB is enough for one user, so it's free from Q2. **BentoPDF** is the light Q1 alternative (in-browser).
- Uploads up to 250 MB (`SYSTEM_MAXFILESIZE` and the Spring multipart limits); Zoraxy must allow that body size.
- `SYSTEM_BACKENDURL`/`FRONTENDURL` and `SERVER_FORWARD_HEADERS_STRATEGY: native` are set for the HTTPS proxies.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
