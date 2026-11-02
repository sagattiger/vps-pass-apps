# Memos

Lightweight notes and microblog. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Memos` |
| Slug | `memos` |
| Category | `Documents & Notes` |
| Description | `Lightweight notes and microblog` |
| Web service | `memos` |
| Web port | `5230` |
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
Open the address and create your account: the first account is the admin.
```

## Image tags

`neosmemo/memos:stable` (the project's recommended production tag; version tags like `26.11.0` exist).

## First login

1. Open the address and create your account: the first account is the admin.
2. Settings → System: turn off sign-up if only you will use it, and set the instance URL to `{{url}}` for share links.

## Admin checks

- SQLite in the `data` volume; ~50 MB RAM idle.
- `MEMOS_INSTANCE_URL` is left unset on purpose: a fresh instance then starts **private**. Setting it at install would start it public. The customer can set the URL in the admin settings.

## Paid products

None: free in every plan.
