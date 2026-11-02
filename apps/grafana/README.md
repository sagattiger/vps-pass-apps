# Grafana

Dashboards for metrics and logs. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Grafana` |
| Slug | `grafana` |
| Category | `Monitoring` |
| Description | `Dashboards for metrics and logs` |
| Web service | `grafana` |
| Web port | `3000` |
| RAM reserved (MB) | `256` |
| Disk reserved (MB) | `1024` |
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
```

## Image tags

`grafana/grafana:13.1.2` (pinned). `grafana/grafana` is the open-source image; `grafana/grafana-oss` stopped receiving updates at 12.4, and `grafana-enterprise` is the commercial edition.

## First login

1. Open the address and log in as `admin` with the password from the login info.
2. **Connections → Data sources**: add Prometheus, InfluxDB, Loki, PostgreSQL, a JSON API…
3. Import a dashboard (Dashboards → New → Import) or build one.

## Admin checks

- **Only Grafana:** there's no Prometheus or other database in the template. Data sources must be reachable from the VM (over the internet, or another app on the same VPS Pass through its public address). Say this on the product page.
- `GF_SERVER_ROOT_URL` is the public HTTPS address, so links, alerts and OAuth callbacks use `https://`; `GF_SECURITY_COOKIE_SECURE` is on.
- `GF_SECURITY_ADMIN_PASSWORD` only applies on the first start; later password changes are made in Grafana.
- Sign-up is off; invite users from Administration → Users.
- Alert emails need SMTP: `GF_SMTP_ENABLED`, `GF_SMTP_HOST`, `GF_SMTP_USER`, `GF_SMTP_PASSWORD`, `GF_SMTP_FROM_ADDRESS`.

## Paid products

None: free in every plan.
