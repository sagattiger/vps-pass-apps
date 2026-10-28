# Anki Sync Server

Self-hosted sync for Anki flashcards. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Anki Sync Server` |
| Slug | `anki-sync` |
| Category | `Education` |
| Description | `Self-hosted sync for Anki flashcards` |
| Web service | `anki` |
| Web port | `8080` |
| RAM reserved (MB) | `160` |
| Disk reserved (MB) | `1024` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
In Anki: Preferences > Syncing > Self-hosted sync server: {{url}}/
Then sync and log in with
User: admin
Password: {{password}}
```

## Image tags

No official image exists for the sync server. The template runs the official `anki` package from PyPI (`anki>=26.9,<27`, Anki's own `python -m anki.syncserver`) on `python:3.12-slim`, instead of an unknown third-party image. It installs into the `data` volume on the first start (about a minute) and only reinstalls when `ANKI_SPEC` changes.

## First login

1. In Anki desktop: **Preferences → Syncing → Self-hosted sync server**: `{{url}}/` (keep the trailing slash).
2. Restart Anki, click Sync, log in with `admin` and the password from the login info.
3. AnkiDroid / AnkiMobile: same address under the custom sync server settings.

## Admin checks

- The first start downloads the package from PyPI, so the VM needs internet; the install can end as *still starting* while pip runs.
- The address may answer 404 on `/`; that's normal for the sync server (clients use `/sync/` and `/msync/`).
- Newer Anki clients can need a newer server: raise `ANKI_SPEC` (e.g. `anki>=27,<28`) and retry the app.
- More users: add `SYNC_USER2: "name:password"` and so on.
- `MAX_SYNC_PAYLOAD_MEGS: 500` for big media collections; Zoraxy must allow uploads that large.

## Paid products

None: free in every plan.
