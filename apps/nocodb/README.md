# NocoDB

Spreadsheet-style database. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `NocoDB` |
| Slug | `nocodb` |
| Category | `Productivity` |
| Description | `Spreadsheet-style database` |
| Web service | `nocodb` |
| Web port | `8080` |
| RAM reserved (MB) | `384` |
| Disk reserved (MB) | `1024` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address: the first account you create is the super admin.
```

## Image tags

`nocodb/nocodb:latest`. NocoDB also publishes version tags: pin to one once tested.

## First login

1. Open the address.
2. The first account you create is the super admin.

## Admin checks

- Data is in SQLite in the `data` volume. For heavy use, Postgres would be the next step (more RAM).

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3.
