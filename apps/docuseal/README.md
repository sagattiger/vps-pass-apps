# DocuSeal

Document signing (DocuSign alternative). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `DocuSeal` |
| Slug | `docuseal` |
| Category | `Documents & Notes` |
| Description | `Document signing (DocuSign alternative)` |
| Web service | `docuseal` |
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
Open the address and create the admin account on the first screen.
```

## Image tags

`docuseal/docuseal:latest` (version tags like `2.4.0` exist; pin one once tested). Uses SQLite in the `data` volume to keep it light.

## First login

1. Open the address and create the admin account.
2. **Settings → Email**: set SMTP so signers receive their links.
3. Upload a PDF and place the signature fields.

## Admin checks

- **Needs SMTP** to email signing requests (set in the web UI); without it, signing links must be copied by hand.
- `SECRET_KEY_BASE` is fixed per install; changing it logs everyone out and breaks encrypted settings.
- For many users or heavy use, switch to Postgres with `DATABASE_URL` (needs a template change and a migration).

## Paid products

None: free in every plan.
