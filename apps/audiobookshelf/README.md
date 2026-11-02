# Audiobookshelf

Audiobook and podcast server. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Audiobookshelf` |
| Slug | `audiobookshelf` |
| Category | `Media` |
| Description | `Audiobook and podcast server` |
| Web service | `audiobookshelf` |
| Web port | `80` |
| RAM reserved (MB) | `256` |
| Disk reserved (MB) | `5120` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address right away and create the root (admin) account.
Mobile apps: server {{url}}
```

## Image tags

`ghcr.io/advplyr/audiobookshelf:latest` (official).

## First login

1. Open the address **right away** and create the root user (first visitor sets it).
2. Create a library pointing to `/audiobooks` or `/podcasts`, then upload books from the web (Upload) or subscribe to podcasts.
3. Android/iOS apps: server `{{url}}`.

## Admin checks

- Uploads through the web go into the volumes; large audiobooks need Zoraxy to allow big request bodies.
- **Disk:** media grows fast; 5 GB reserved is only a start. Watch disk use.

## Paid products

None: free in every plan.
