# Dolibarr

ERP and CRM for small businesses. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Dolibarr` |
| Slug | `dolibarr` |
| Category | `Business` |
| Description | `ERP and CRM for small businesses` |
| Web service | `dolibarr` |
| Web port | `80` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `2048` |
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

`dolibarr/dolibarr:latest` (the official image; version tags exist), `mariadb:11.4` (LTS).

## First login

1. Log in as `admin` with the password from the login info.
2. Home → Setup → Company: fill in the company details.
3. Home → Setup → Modules: turn on what you need (invoices, CRM, stock, projects…).

## Admin checks

- Installed automatically on the first start (`DOLI_INSTALL_AUTO`). `DOLI_ADMIN_PASSWORD` only applies then.
- `DOLI_COMPANY_COUNTRYCODE: BR` (most qsync customers are in Brazil; Dolibarr needs a country for some modules). Change it in the template for other countries.
- Cron is on (`DOLI_CRON`, key `{{secret}}`) for scheduled jobs.
- Uploads up to 64 MB.
- Upgrades: to move to a new major, delete `install.lock` from the `documents` volume and restart, as upstream documents.

## Paid products

None: free in every plan.
