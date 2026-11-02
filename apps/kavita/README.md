# Kavita

Ebook, comic and manga reader. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Kavita` |
| Slug | `kavita` |
| Category | `Media` |
| Description | `Ebook, comic and manga reader` |
| Web service | `kavita` |
| Web port | `5000` |
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
Open the address right away and create the admin account.
```

## Image tags

`jvmilazz0/kavita:latest` (the official image named in Kavita's docs).

## First login

1. Open the address **right away** and create the admin account (first visitor sets it).
2. Add books: Upload from the VM: `sudo cp -r <folder> /var/lib/docker/volumes/qa<id>_library/_data/` (or `scp`/`rsync` to the VM first), then rescan in the app.
3. Server settings → Libraries: add `/library`.

## Admin checks

- **No upload in the web UI**: books are copied into the `library` volume from the VM (command above). Mention this on the product page.
- OPDS feed for reader apps is in the user settings.

## Paid products

None: free in every plan.
