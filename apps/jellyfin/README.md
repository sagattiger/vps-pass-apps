# Jellyfin

Media server for movies, TV and music. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Jellyfin` |
| Slug | `jellyfin` |
| Category | `Media` |
| Description | `Media server for movies, TV and music` |
| Web service | `jellyfin` |
| Web port | `8096` |
| RAM reserved (MB) | `1024` |
| Disk reserved (MB) | `8192` |
| Free from | **Q2** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address and finish the setup wizard: language, admin user and password, then add the /media library.
```

## Image tags

`jellyfin/jellyfin:10.11.6` is the current stable patch of the 10.11 line. `:latest` is not used: Jellyfin publishes unstable and pre-release builds under their own tags and `latest` has tracked pre-releases before.

## First login

1. Open the address and pick the language.
2. Create the admin user and password.
3. Add a library with the folder `/media` (the named volume).
4. Leave the remote-access step alone: TLS and the public URL are handled by the edge proxies.

## Admin checks

- **There is no media inside the image.** The customer has to put files into the `qa<id>_jellyfin_media` volume (SSH to the VM: `docker cp ./movie.mkv qa<id>-jellyfin-1:/media/`) and then add `/media` as a library. Host paths are not allowed by the template rules, so a bind mount of a NAS folder cannot be used here.
- DLNA discovery needs UDP 1900 and host networking, neither of which VPS Pass offers. Jellyfin's own web and mobile clients work fine over HTTPS; DLNA TVs will not find the server.
- Transcoding: Q1/Q2 have 2 vCPU and no GPU passthrough, so 1080p direct play is fine and anything that needs to transcode will struggle. Tell customers to prefer direct-play-compatible files.
- `JELLYFIN_PublishedServerUrl` is set to the public HTTPS address so cast/remote URLs and share links point at `https://`, not at the container.
- Behind Zoraxy + two Traefiks, Jellyfin sees a proxy IP. Add those ranges under Dashboard → Networking → Known proxies if per-client bandwidth limits or logs matter.

## Paid products

Needs a *Core VPS app* price product for Q1.
