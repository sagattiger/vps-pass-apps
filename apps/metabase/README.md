# Metabase

Dashboards and BI. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Metabase` |
| Slug | `metabase` |
| Category | `Analytics` |
| Description | `Dashboards and BI` |
| Web service | `metabase` |
| Web port | `3000` |
| RAM reserved (MB) | `1536` |
| Disk reserved (MB) | `2048` |
| Free from | **Q3** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
The first start takes 2-3 minutes. Then open the address and create the admin account.
```

## Image tags

`metabase/metabase:latest`. Metabase publishes only full version tags (`v0.5x.y`) besides `latest`: pin to one once tested.

## First login

1. Wait: the first start takes 2–3 minutes (Java + migrations). The install may finish as *still starting*; that's normal.
2. Open the address and create the admin account.

## Admin checks

- The application database is H2 (a file in the `data` volume). Metabase recommends Postgres in production because H2 can be damaged by unclean shutdowns. Possible improvement: add a `postgres:16-alpine` service (`MB_DB_TYPE=postgres`, about +150 MB RAM).
- Java on 2 vCPU (Q1/Q2) starts slowly, one reason it's free only from Q3.

## Paid products

Needs a **Q1 price** and a (cheaper) **Q2 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q3. Price not set yet.
