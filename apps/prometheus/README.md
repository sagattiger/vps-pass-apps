# Prometheus

Metrics database and monitoring (data source for Grafana). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Prometheus` |
| Slug | `prometheus` |
| Category | `Monitoring` |
| Description | `Metrics database and monitoring (data source for Grafana)` |
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
Grafana data source: {{url}} with basic auth (same user and password).
Edit scrape targets in the VM:
docker run --rm -it -v qa{{app_id}}_config:/c alpine vi /c/prometheus.yml
```

## Image tags

`prom/prometheus:latest` (official; version tags like `v3.x.y` exist, pin one once tested), `caddy:2-alpine` in front for the login.

## First login

1. Log in as `admin` with the password from the login info.
2. Add scrape targets (node_exporter on your servers, apps with `/metrics`) to `prometheus.yml` in the VM (command in the login info), then reload: `curl -u admin:<password> -X POST {{url}}/-/reload`.
3. In Grafana: add a Prometheus data source with this address and basic auth.

## Admin checks

- **Prometheus has no login of its own**, so Caddy's password page protects the UI, the API and remote write.
- Servers can also **push** metrics (`--web.enable-remote-write-receiver`) with Grafana Alloy/Agent to `{{url}}/api/v1/write` using basic auth, which avoids opening exporter ports.
- The `config` volume starts with the image's default `prometheus.yml` (it scrapes itself).
- Retention 15 days; disk grows with the number of series.

## Paid products

None: free in every plan.
