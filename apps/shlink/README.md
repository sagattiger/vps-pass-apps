# Shlink

URL shortener with stats and REST API. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Shlink` |
| Slug | `shlink` |
| Category | `Marketing` |
| Description | `URL shortener with stats and REST API` |
| Web service | `shlink` |
| Web port | `8080` |
| RAM reserved (MB) | `128` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Short links: {{url}}/<code>
Manage them at https://app.shlink.io (Add server: URL {{url}}, API key {{secret}})
or with the REST API (header X-Api-Key).
```

## Image tags

`shlinkio/shlink:stable` (the latest stable release; major tags like `4` exist).

## First login

1. Open https://app.shlink.io, **Add a server** with URL `{{url}}` and the API key from the login info (the web client runs in the browser; the key stays local).
2. Create short links; they work at `{{url}}/<code>`.

## Admin checks

- SQLite in the `data` volume (`/etc/shlink/data`).
- `DEFAULT_BASE_URL_REDIRECT` sends visitors of the bare address to the Shlink web client (otherwise `/` is a 404 and the install would end as *still starting*). Change it to the customer's site if they prefer.
- **Visit locations** need a free MaxMind `GEOLITE_LICENSE_KEY`; without it stats still count visits but not countries/cities.
- The address is a subdomain of `apps.qsync.net`; for real branded short links the customer would need their own domain (custom domains are a separate topic).

## Paid products

None: free in every plan.
