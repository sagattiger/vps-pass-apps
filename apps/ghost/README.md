# Ghost

Blog, newsletter and membership publishing. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Ghost` |
| Slug | `ghost` |
| Category | `Websites` |
| Description | `Blog, newsletter and membership publishing` |
| Web service | `ghost` |
| Web port | `2368` |
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
Open {{url}}/ghost right away and create the owner account.
Your site: {{url}}
```

## Image tags

`ghost:6-alpine` (the official image, Ghost 6), `mysql:8.4` (Ghost supports only MySQL 8 in production, not MariaDB).

## First login

1. Open `{{url}}/ghost` **right away** and create the owner account (the first visitor sets it up).
2. Settings: site title, design, navigation; Members/Newsletter if wanted.

## Admin checks

- `url` is the public HTTPS address; Ghost builds every link from it, so it must match.
- **Newsletters and member sign-in emails need Mailgun/SMTP**: set `mail__transport: SMTP` and `mail__options__*` (transactional mail), and Mailgun in Settings for bulk newsletters.
- Ghost 6's optional extras (ActivityPub social web, Tinybird analytics) are not included; they need extra services.

## Paid products

None: free in every plan.
