# CyberChef

The Cyber Swiss Army Knife (encode, decode, convert, analyse). Status: **Testing**.

## Catalogue fields (Proxmox → Core VPS apps)

| Field | Value |
|---|---|
| Name | `CyberChef` |
| Slug | `cyberchef` |
| Category | `Developer` |
| Description | `The Cyber Swiss Army Knife (encode, decode, convert, analyse)` |
| Web service | `cyberchef` |
| Web port | `8080` |
| RAM reserved (MB) | `32` |
| Disk reserved (MB) | `256` |
| Free from | **Q1** |
| Status | Testing |

## Docker compose

Paste [`docker-compose.yml`](docker-compose.yml) as it is. The installer adds the Traefik labels and the `qsync` network.

## Run once before the first start

Leave empty.

## Login info

```
Open the address. No account needed: everything runs in your browser.
```

## Image tags

`ghcr.io/gchq/cyberchef:latest` (GCHQ's official image; it listens on port 8080).

## First login

1. Open the address and drag operations into the recipe.

## Admin checks

- Static, client-side only: data never leaves the browser. Nothing to back up.

## Paid products

None: free in every plan.
