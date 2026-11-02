# Loki

Log aggregation (data source for Grafana). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Loki` |
| Slug | `loki` |
| Category | `Monitoring` |
| Description | `Log aggregation (data source for Grafana)` |
| Web service | `web` |
| Web port | `8080` |
| RAM reserved (MB) | `384` |
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
Password: {{password}}
Push logs to {{url}}/loki/api/v1/push and add Loki in Grafana with this address and basic auth.
```

## Image tags

`grafana/loki:latest` (official, Loki 3.x single-binary with the image's default filesystem config; pin a version once tested), `caddy:2-alpine` in front.

## First login

1. Ship logs with Grafana Alloy (or Promtail) on your servers to `{{url}}/loki/api/v1/push`, basic auth `admin` / password from the login info.
2. In Grafana: add a Loki data source with this address and basic auth, then use Explore.

## Admin checks

- **Loki has no login of its own and no web UI**; Caddy's password page protects the API. Opening the address in a browser just asks for the password.
- The image's default config stores chunks and index on the filesystem (`/loki`, the `data` volume) and keeps logs **forever**; set `limits_config.retention_period` plus the compactor if a customer sends a lot of logs.
- Single tenant (`auth_enabled: false` behind Caddy).

## Paid products

None: free in every plan.
