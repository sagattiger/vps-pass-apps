# Forgejo

Git hosting (community fork of Gitea). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `Forgejo` |
| Slug | `forgejo` |
| Category | `Developer` |
| Description | `Git hosting (community fork of Gitea)` |
| Web service | `forgejo` |
| Web port | `3000` |
| RAM reserved (MB) | `384` |
| Disk reserved (MB) | `2048` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address, keep the suggested settings (SQLite) and create the administrator account at the bottom of the page. Clone over HTTPS.
```

## Image tags

`codeberg.org/forgejo/forgejo:15` (v15 LTS; newer majors come every quarter, v17 is the latest, but the LTS changes less often).

## First login

1. Open the address right after the install (whoever opens the install page first sets it up).
2. Keep the suggested settings (SQLite).
3. Create the administrator account at the bottom of the page.

## Admin checks

- `DISABLE_SSH: "true"`: VPS Pass routes HTTP only, so clones go over HTTPS and Forgejo doesn't show SSH URLs.
- The image comes from `codeberg.org`. If Codeberg's registry is down, `data.forgejo.org/forgejo/forgejo` is the mirror.
- Email needs SMTP, set by the customer in `app.ini` or via `FORGEJO__mailer__*` variables.

## Paid products

None: free in every plan.
