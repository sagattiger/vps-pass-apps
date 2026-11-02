# Excalidraw

Hand-drawn style whiteboard and diagrams. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Excalidraw` |
| Slug | `excalidraw` |
| Category | `Productivity` |
| Description | `Hand-drawn style whiteboard and diagrams` |
| Web service | `excalidraw` |
| Web port | `80` |
| RAM reserved (MB) | `32` |
| Disk reserved (MB) | `256` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and draw. Drawings are saved in your browser; export or save files to keep them.
```

## Image tags

`excalidraw/excalidraw:latest` (official static build).

## First login

1. Open the address and draw. Save with **Save to disk** (`.excalidraw`) or export PNG/SVG.

## Admin checks

- Static app: drawings live in the browser's local storage, not on the server.
- **Live collaboration and share links** use Excalidraw's own public servers (collab room server and JSON storage) unless self-hosted separately; they still work, but the data passes through excalidraw.com (end-to-end encrypted).

## Paid products

None: free in every plan.
