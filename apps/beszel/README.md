# Beszel

Lightweight server monitoring (CPU, RAM, disk, Docker stats). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Beszel` |
| Slug | `beszel` |
| Category | `Monitoring` |
| Description | `Lightweight server monitoring (CPU, RAM, disk, Docker stats)` |
| Web service | `beszel` |
| Web port | `8090` |
| RAM reserved (MB) | `64` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address right away and create the admin account.
Then Add System: copy the agent command and run it on each server you want to monitor.
```

## Image tags

`henrygd/beszel:latest` (the hub; official).

## First login

1. Open the address **right away** and create the admin account (first visitor sets it up).
2. **Add System**: Beszel shows a `docker run`/install command for the agent; run it on each server to monitor.

## Admin checks

- Only the **hub** is in the template. Agents run on the customer's servers and connect to the hub over HTTPS (WebSocket to `APP_URL`), so no extra port is needed.
- Monitoring the VPS Pass itself would need an agent with access to the host (Docker socket, host network), which templates don't allow; the customer can install the agent on the VM directly.
- Alerts (email, Telegram, Discord, ntfy…) are set per system.

## Paid products

None: free in every plan.
