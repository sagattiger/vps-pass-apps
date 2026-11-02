# draw.io

Diagram editor (flowcharts, network, UML). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `draw.io` |
| Slug | `drawio` |
| Category | `Productivity` |
| Description | `Diagram editor (flowcharts, network, UML)` |
| Web service | `drawio` |
| Web port | `8080` |
| RAM reserved (MB) | `384` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and create a diagram. Save to your device, or connect Google Drive / OneDrive / GitHub in the app.
```

## Image tags

`jgraph/drawio:latest` (official, Tomcat; serves HTTP on 8080).

## First login

1. Open the address, choose **Device** as storage, and draw.

## Admin checks

- Diagrams are stored where the user saves them (their device or cloud drive), not on the server. Nothing to back up.
- Tomcat uses ~300 MB RAM at idle.

## Paid products

None: free in every plan.
