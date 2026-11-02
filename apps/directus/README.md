# Directus

Headless CMS and instant REST/GraphQL API. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Directus` |
| Slug | `directus` |
| Category | `Developer` |
| Description | `Headless CMS and instant REST/GraphQL API` |
| Web service | `directus` |
| Web port | `8055` |
| RAM reserved (MB) | `384` |
| Disk reserved (MB) | `1536` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Email: {{email}}
Password: {{password}}
```

## Image tags

`directus/directus:11` (major pin; upstream recommends pinning a version for production).

## First login

1. Log in with the customer's email and the password from the login info.
2. Create collections (tables); the REST and GraphQL APIs are at `{{url}}/items/<collection>` and `{{url}}/graphql`.

## Admin checks

- SQLite in the `database` volume keeps it light. For bigger projects, switch to Postgres (`DB_CLIENT: pg` plus a `postgres` service).
- The admin is created from `ADMIN_EMAIL`/`ADMIN_PASSWORD` on the first start.
- Email (password reset, invites) needs `EMAIL_*` SMTP variables.

## Paid products

None: free in every plan.
