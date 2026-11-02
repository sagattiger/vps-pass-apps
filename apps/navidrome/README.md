# Navidrome

Music streaming server (Subsonic compatible). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Navidrome` |
| Slug | `navidrome` |
| Category | `Media` |
| Description | `Music streaming server (Subsonic compatible)` |
| Web service | `navidrome` |
| Web port | `4533` |
| RAM reserved (MB) | `128` |
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
Subsonic apps (DSub, Symfonium, Feishin...): server {{url}}
```

## Image tags

`deluan/navidrome:latest` (official).

## First login

1. Open the address **right away** and create the admin account (first visitor sets it).
2. Add music: Upload from the VM: `sudo cp -r <folder> /var/lib/docker/volumes/qa<id>_music/_data/` (or `scp`/`rsync` to the VM first), then rescan in the app.
3. Use any Subsonic app with server `{{url}}`.

## Admin checks

- **No upload in the web UI**: Navidrome only reads music. Customers copy files into the `music` volume from the VM (command above). Mention this on the product page.
- The music volume is mounted read-only in the container; Navidrome rescans every hour.
- **Disk:** music grows fast; 5 GB reserved is only a start.

## Paid products

None: free in every plan.
