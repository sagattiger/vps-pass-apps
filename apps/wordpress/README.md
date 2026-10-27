# WordPress

Website and blog. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `WordPress` |
| Slug | `wordpress` |
| Category | `Websites` |
| Description | `Website and blog` |
| Web service | `wordpress` |
| Web port | `80` |
| RAM reserved (MB) | `512` |
| Disk reserved (MB) | `3072` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and follow the WordPress installer.
```

## Image tags

`wordpress:6-apache` (major pin), `mariadb:11`.

## First login

1. Open the address.
2. Follow the WordPress installer (site title, admin user, password).

## Admin checks

- HTTPS: the official image switches to HTTPS when it gets `X-Forwarded-Proto: https`, so there's no redirect loop behind the proxies.
- **Upload limit:** PHP's default upload size is small (2 MB), so big theme / plugin / media uploads fail. Possible improvement: raise `upload_max_filesize` / `post_max_size` with an extra ini file.
- Email (password reset, forms) needs an SMTP plugin; WordPress's `mail()` won't deliver from the VM.
- Open the installer right after the install: whoever opens it first sets up the site.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3.
