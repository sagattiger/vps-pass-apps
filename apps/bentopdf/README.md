# BentoPDF

Private PDF toolkit in the browser. Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `BentoPDF` |
| Slug | `bentopdf` |
| Category | `Documents & Notes` |
| Description | `Private PDF toolkit in the browser` |
| Web service | `bentopdf` |
| Web port | `8080` |
| RAM reserved (MB) | `64` |
| Disk reserved (MB) | `512` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address. No account needed: files are processed in your browser and never uploaded.
```

## Image tags

`ghcr.io/alam00000/bentopdf-simple:latest`: the *Simple Mode* build (all tools, no marketing pages), which the project recommends for self-hosting. The full build is meant for public branded sites and needs AGPL compliance or a commercial license.

## First login

1. Open the address and pick a tool. No account.

## Admin checks

- Fully client-side: PDFs are processed in the visitor's browser, the server only serves static files. Very light, nothing to back up.
- There's no login, so anyone with the address can use it (it costs the server almost nothing).
- Office conversion needs cross-origin isolation (HTTPS, which VPS Pass has, plus COOP/COEP headers the image sends). If Office tools fail, check those headers aren't stripped by a proxy.

## Paid products

None: free in every plan.
