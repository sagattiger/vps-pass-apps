# Trilium Notes

Hierarchical notes and personal knowledge base. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Trilium Notes` |
| Slug | `trilium` |
| Category | `Documents & Notes` |
| Description | `Hierarchical notes and personal knowledge base` |
| Web service | `trilium` |
| Web port | `8080` |
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
Open the address right away and set your password (Trilium is single-user).
```

## Image tags

`triliumnext/trilium:latest` (the official image; upstream recommends pinning a version tag such as `v0.9x.y`, since `latest` can jump minor versions).

## First login

1. Open the address **right away**: choose *new document* and set the password (whoever opens it first sets it).
2. Desktop app: set up sync with server `{{url}}`.

## Admin checks

- Single user: one password protects everything.
- The desktop app can sync with this server (Options → Sync) for offline use.
- Back up the `data` volume (the SQLite document plus backups Trilium makes itself).

## Paid products

None: free in every plan.
