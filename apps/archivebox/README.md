# ArchiveBox

Save web pages, videos and articles. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `ArchiveBox` |
| Slug | `archivebox` |
| Category | `Archiving` |
| Description | `Save web pages, videos and articles` |
| Web service | `archivebox` |
| Web port | `8000` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `6144` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Log in at {{url}}/admin
User: admin
Password: {{password}}
```

## Image tags

`archivebox/archivebox:stable` (the project's stable channel; it includes Chromium, wget and yt-dlp, so the image is large).

## First login

1. Open `{{url}}/admin` and log in as `admin` with the password from the login info.
2. Add URLs with **Add**, or import bookmarks / RSS.

## Admin checks

- Private by default: `PUBLIC_INDEX`, `PUBLIC_SNAPSHOTS` and `PUBLIC_ADD_VIEW` are off, so nothing is visible without logging in.
- `SAVE_ARCHIVE_DOT_ORG: False`: URLs are not also sent to archive.org (privacy). The customer can turn it on.
- Both the old (`ALLOWED_HOSTS`, `CSRF_TRUSTED_ORIGINS`) and the new (`BASE_URL`) proxy settings are set, so login works behind HTTPS on 0.7 and 0.9. If login fails with *CSRF verification failed*, check the version in the logs.
- **Disk:** Chromium screenshots, PDFs and videos grow fast; 6 GB reserved is a start. Video downloads are capped at 750 MB each (`MEDIA_MAX_SIZE`).
- RAM 1 GB with Chromium running; archiving many pages at once uses more.

## Paid products

Needs a **Q1 price** product (type *Core VPS app*), picked on the catalogue app. Free in Q2 and Q3. Price not set yet.
